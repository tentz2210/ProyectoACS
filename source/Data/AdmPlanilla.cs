using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProyPlanilla.Data
{
    public class AdmPlanilla
    {

        private MySqlService DAO;
        public AdmPlanilla()
        {
            DAO = new MySqlService();
        }

        public async Task generarReporteAsync()
        {
            await DAO.generarReporteAsync();
        }

    }
}
