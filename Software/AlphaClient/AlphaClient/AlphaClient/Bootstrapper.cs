using Microsoft.Practices.ServiceLocation;
using Prism.Mef;
using Prism.Modularity;
using Prism.Regions;
using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;
using System.ComponentModel.Composition.Hosting;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace AlphaClient
{
    public class Bootstrapper : MefBootstrapper
    {
        protected override DependencyObject CreateShell()
        {
            var compContainer = this.Container.GetExportedValue<MainView>();
            return compContainer;
        }

        protected override void InitializeShell()
        {
            base.InitializeShell();

            Application.Current.MainWindow = CreateShell() as Window;
            Application.Current.MainWindow.Show();
        }

        protected override IModuleCatalog CreateModuleCatalog()
        {
            // When using MEF, the existing Prism ModuleCatalog is still
            // the place to configure modules via configuration files.
            return new ConfigurationModuleCatalog();
        }

        protected override void ConfigureContainer()
        {
            base.ConfigureContainer();

            this.Container.ComposeExportedValue<IRegionManager>(new RegionManager());
        }

        protected override void ConfigureAggregateCatalog()
        {
            base.ConfigureAggregateCatalog();

            AssemblyCatalog shellCatalog = new AssemblyCatalog(typeof(MainView).Assembly);
            this.AggregateCatalog.Catalogs.Add(shellCatalog);

            // TODO:  Expand to use configurable directory folder locations

            // MaZ todo: uncomment for appropriate libs
            //DirectoryCatalog catalog = new DirectoryCatalog(".\\", "AlphaClient.*.dll");
            //this.AggregateCatalog.Catalogs.Add(catalog);
        }
    }
}
