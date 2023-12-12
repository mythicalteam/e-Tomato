using ETomato.Api.DataAccess.Users.Login;
using ETomato.Api.Services.Auth;
using ETomato.Api.Shared.Users.Login;
using FastEndpoints;

namespace ETomato.Api.Services.Users.Login;

public sealed class EndPoint(IRepositoryFactory factory, AuthService authService) : Endpoint<Request, Response>
{
    public override void Configure()
    {
        Get("users/login");
        AllowAnonymous();
    }

    public override async Task HandleAsync(Request req, CancellationToken ct)
    {
        var repository = factory.Create<Repository>();
        var result = await repository.ExecuteAsync(req, ct);

        await result.Match<Task>(
            async user =>
            {
                var token = await authService.CreateTokenAsync(user,  ct);
                var response = new Response { Token = token, User = user };
                await SendAsync(response, cancellation: ct);
            },
            error =>
            {
                AddError(error.Message);
                return SendErrorsAsync(cancellation: ct);
            });
    }
}