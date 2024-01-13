using DataAccess.DbAccess;

namespace MinimalApiDemo;

public class Program
{
    public static async Task Main(string[] args)
    {
        WebApplicationBuilder? builder = WebApplication.CreateBuilder(args);

        ManageServices(builder);

        WebApplication? app = builder.Build();

        if (app != null) ManageApp(app);

        if (app != null) app.Run();
    }

    private static void ManageServices(WebApplicationBuilder builder)
    {
        // Add services to the container.
        builder.Services.AddAuthorization();

        // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();
        builder.Services.AddSingleton<ISqlDataAccess, SqlDataAccess>();
        builder.Services.AddSingleton<IUserData, UserData>();
    }

    private static void ManageApp(WebApplication app)
    {
        // Configure the HTTP request pipeline.
        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        app.UseHttpsRedirection();

        app.UseAuthorization();

        app.ConfigureApi();
    }
}
