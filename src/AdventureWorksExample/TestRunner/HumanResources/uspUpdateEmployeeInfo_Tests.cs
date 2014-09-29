using NUnit.Framework;

namespace TestRunner.HumanResources
{
    [TestFixture]
    public class HumanResources_uspUpdateEmployeeHireInfo_Tests
    {
        private TestGateway _gateway;

        [TestFixtureSetUp]
        public void Setup()
        {
            _gateway = new TestGateway("server=.;integrated security=sspi;initial catalog=AdventureWorks2012");   //obviously this shouldn't be hard coded!
        }

        [Test]
        public void uspUpdateEmployeeHireInfo_currentflag_is_set_to_true_when_hired()
        {   
            var messages = _gateway.RunTest("[HumanResourcesTests].[test uspUpdateEmployeeHireInfo_currentflag_is_set_to_true_when_hired]");

            Assert.IsTrue(messages.Contains("1 succeeded"), "Error running tSQLt test, messages: {0}", messages);
        }

       
    }
}
