using System.Reflection;
using ETomato.Api.DataAccess.Users.Seed;
using MongoDB.Bson.Serialization.Conventions;
using MongoSharpen;

namespace ETomato.Api.DataAccess;

public class DbInitializer(IRepositoryFactory repositoryFactory)
{
    public Task InitAsync()
    {
        var defaultConnection = "mongodb://localhost:6130";
        var connectionVariable = Environment.GetEnvironmentVariable("MONGO_CONNECTION");
        if (!string.IsNullOrWhiteSpace(connectionVariable)) defaultConnection = connectionVariable;

        DbFactory.DefaultConnection = defaultConnection;
        DbFactory.DefaultDatabase = "etomato-db";
        DbFactory.SetGlobalFilter<IDeleteOn>("{ deleted: false }", Assembly.GetAssembly(typeof(BaseDocument))!);
        DbFactory.AddConvention("ignore-extra-elements", new IgnoreExtraElementsConvention(true));

        return SeedDefaultUserAsync();
    }

    private Task SeedDefaultUserAsync()
    {
        var repo = repositoryFactory.Create<Repository>();
        return repo.ExecuteAsync();
    }
}