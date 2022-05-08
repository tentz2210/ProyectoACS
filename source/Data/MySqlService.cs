using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;

using MySql.Data;
using MySql.Data.MySqlClient;

namespace ProyPlanilla.Data
{
    public class MySqlService
    {
        private MySqlConnection conn;
        private String connString = "server=127.0.0.1;uid=root;pwd=1234;database=proy_acs;Connect Timeout=8000";

        public void abrirConexion()
        {
            try
            {
                conn = new MySqlConnection(connString);
                conn.Open();
            }
            catch (MySqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public async Task generarReporteAsync()
        {
            try
            {
                abrirConexion();
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "sp_generarReporte";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 8000;

                await Task.Run(() => cmd.ExecuteNonQuery());

                conn.Close();
            }
            catch(MySqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            
        }
    }
}
