using DataAccess.DbAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Data;

public class UserData : IUserData
{
    private readonly ISqlDataAccess db;

    private const string dboPrefix = "dbo";


    public Task<IEnumerable<UserModel>> GetUsers()
    {
        return db.LoadData<UserModel, dynamic>($"{dboPrefix}.{StoredProcedure.spUser_GetAll}", new { });
    }

    public async Task<UserModel?> GetUser(int id)
    {
        IEnumerable<UserModel>? results = await db.LoadData<UserModel, dynamic>(
            $"{dboPrefix}.{StoredProcedure.spUser_Get}",
            new { Id = id });
        return results.FirstOrDefault();
    }

    public Task InsertUser(UserModel user)
    {
        return db.SaveData($"{dboPrefix}.{StoredProcedure.spUser_Insert}", new { user.FirstName, user.LastName, user.Email });
    }

    public Task UpdateUser(UserModel user)
    {
        return db.SaveData($"{dboPrefix}.{StoredProcedure.spUser_Update}", user);
    }

    public Task DeleteUser(int id)
    {
        return db.SaveData($"{dboPrefix}.{StoredProcedure.spUser_Delete}", new { Id = id });
    }


    public UserData(ISqlDataAccess _db)
    {
        db = _db;
    }


    private enum StoredProcedure
    {
        spUser_Delete,
        spUser_Get,
        spUser_GetAll,
        spUser_Insert,
        spUser_Update
    }
}
