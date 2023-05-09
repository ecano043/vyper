const Customer = artifacts.require("customer");

contract("customer", (accounts) => {
    it("should create a new order batch and return it", async () => {
        const customerInstance = await Customer.deployed();
        let nombre = "Eli"
        let table = "mesa001"
        const tx = await customerInstance.saveNewCustomerFemale(nombre, table);
        const customerFromContract = await manufacturerInstance.getCustomer(nombre);
        assert.equal(customerFromContract.name, nombre, "El nombre recibido es distinto al enviado");
    });

    it("should fail if searching for an inexistent customer", async () => {
        const customerInstance = await Customer.deployed();
        const inexistentCustomerName = "doesntexist";
        try {
            const tx = await customerInstance.getCustomer(inexistentCustomerName);
        } catch (error) {
            assert.include(error.message, "revert", "El mensaje de error debería contener revert")
        }
    })
})