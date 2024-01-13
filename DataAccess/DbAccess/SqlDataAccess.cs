using Dapper;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DbAccess;

public class SqlDataAccess : ISqlDataAccess
{
    private readonly IConfiguration config;

    public async Task<IEnumerable<T>> LoadData<T, U>(
        string storedProcedure,
        U parameters,
        string connectionId = "Default")
    {
        using IDbConnection connection = new SqlConnection(config.GetConnectionString(connectionId)); // note that this using approach avoids the need to enclose what follows in a block

        return await connection.QueryAsync<T>(storedProcedure, parameters, // the QueryAsync extension method comes from Dapper
            commandType: CommandType.StoredProcedure);
    }

    public async Task SaveData<T>(
        string storedProcedure,
        T parameters,
        string connectionId = "Default")
    {
        using IDbConnection connection = new SqlConnection(config.GetConnectionString(connectionId));

        await connection.ExecuteAsync(storedProcedure, parameters, // the ExecuteAsync extension method comes from Dapper
            commandType: CommandType.StoredProcedure);
    }

    public SqlDataAccess(IConfiguration _config)
    {
        config = _config;
    }
}
