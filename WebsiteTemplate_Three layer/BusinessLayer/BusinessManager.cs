using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using BusinessLayer;
using DataAccessLayer;

namespace BusinessLayer
{
    public class BusinessManager
    {
        public string ConnectionString { get; set; }
        private DBManager _dbManager;
        public DBManager DBManager
        {
            get
            {
                return _dbManager;
            }
            set
            {
                _dbManager = value;
            }
        }

        public BusinessManager()
        {
           
        }

        public List<Supplier> ManageSupplier(Supplier obj, OperationTypes operationType)
        {
            List<Supplier> result = new List<Supplier>();
            switch (operationType)
            {
                case OperationTypes.NotDefined:                    
                    break;
                case OperationTypes.Add:
                    obj.addSupplier();
                    break;
                case OperationTypes.Update:
                    obj.updateSupplier();
                    break;
                case OperationTypes.Delete:
                    obj.deleteSupplier();
                    break;
                case OperationTypes.GetAll:
                   result = obj.GetAllSupplier();
                    break;
                case OperationTypes.GetSpecific:
                   result = obj.GetSpecificSupplier();
                    break;
                default:
                    break;

            }
            return result;

        }

        
    }
}
