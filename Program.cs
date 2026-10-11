using Npgsql;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Haal de connectionstring op uit de omgevingsvariabelen (Environment Variables)
var connString = Environment.GetEnvironmentVariable("CONNECTION_STRING") 
    ?? "Host=postgresdb;Database=appdb;Username=postgres;Password=mysecretpassword";

app.MapGet("/", () => "Hello World v3.0 - .NET 8 met PostgreSQL Database op Jenkins!");

// Nieuw endpoint om de databaseverbinding te testen
app.MapGet("/db-check", () =>
{
    try
    {
        using var conn = new NpgsqlConnection(connString);
        conn.Open();
        return "SUCCESS: Verbinding met PostgreSQL database is geslaagd!";
    }
    catch (Exception ex)
    {
        return $"ERROR: Database verbinding mislukt - {ex.Message}";
    }
});

app.Run();