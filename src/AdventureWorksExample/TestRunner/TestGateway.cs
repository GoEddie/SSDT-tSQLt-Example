using System.Data;
using System.Data.SqlClient;

namespace TestRunner
{
    class TestGateway
    {
        private readonly string _connectionString;

        public TestGateway(string connectionString)
        {
            _connectionString = connectionString;
        }

        public string RunTest(string testName)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                using (var cmd = connection.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "tSQLt.Run";
                    cmd.Parameters.AddWithValue("@TestName", testName);
                    string messages = "";

                    connection.FireInfoMessageEventOnUserErrors = true;
                    connection.InfoMessage += (sender, args) =>
                    {
                        messages += "\r\n" + args.Message;
                    };

                    cmd.ExecuteNonQuery();
                    return messages;
                }
            }
        }
    }
}
