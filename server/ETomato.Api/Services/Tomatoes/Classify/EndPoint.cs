﻿using ETomato.Api.DataAccess.Tomatoes.Classify;
using ETomato.Api.Shared.Tomatoes.Classify;
using FastEndpoints;

namespace ETomato.Api.Services.Tomatoes.Classify;

public class EndPoint(IRepositoryFactory factory) : Endpoint<Request>
{
    public override void Configure()
    {
        Post("classify");
        AllowFileUploads();
        AllowAnonymous();
    }

    public override async Task HandleAsync(Request request, CancellationToken ct)
    {
        try
        {
            byte[] imageBytes;
            using (var stream = new MemoryStream())
            {
                await request.Image.CopyToAsync(stream, ct);
                imageBytes = stream.ToArray();
            }
            var imageString = Convert.ToBase64String(imageBytes);

            var repository = factory.Create<Repository>();

            var result = await repository.ExecuteAsync(imageString, ct);

            await result.Match(
                diagnosis => SendAsync(diagnosis, cancellation: ct),
                error =>
                {
                    AddError(error.Message);
                    return SendErrorsAsync(cancellation: ct);
                });
        }
        catch (OperationCanceledException)
        {
            //ignore
        }
    }
}