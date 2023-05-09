# @version ^0.3.7

interface Restaurant:
    def saveNewMenuStarter(name: String[50], price: uint256): nonpayable
    def saveNewMenuMainCourse(name: String[50], price: uint256): nonpayable
    def saveNewMenuDessert(name: String[50], price: uint256): nonpayable
    def saveNewMenuDrink(name: String[50], price: uint256): nonpayable
    def changeStateOrder(table: String[50], status: OrderStatus): nonpayable
    def saveNewOrder(table: String[50], name: String[50]): nonpayable
    def getOrder(table: String[50]) -> Order: view
    def getMenu(name: String[50]) -> Menu: view


enum CustomerGender:
    MALE
    FEMALE
    OTHER

enum CustomerStatus:
    ATTENDED
    NOT_ATTENDED
    CHARGED

enum OrderStatus:
    ENQUEUED
    IN_PREPARATION
    COOCKED
    SERVED


struct Customer:
    name: String[50]
    table: String[50]
    gender: CustomerGender
    status: CustomerStatus

enum MenuType:
    STARTER
    MAIN_COURSE
    DESSERT
    DRINK

struct Order:
    status: OrderStatus
    menuType: MenuType
    table: String[50]
    customer: String[50]

struct Menu:
    name: String[50]
    menuType: MenuType
    price: uint256




owner: address

customers: HashMap[String[50], Customer]

@external
def __init__():
    self.owner = msg.sender

@external
def saveNewCustomerMale(name: String[50], table: String[50]):
    assert msg.sender == self.owner, "Esta funcion solo puede ser accedida por el owner"
    customer: Customer = Customer({name: name, table: table, gender: CustomerGender.MALE, status: CustomerStatus.NOT_ATTENDED})
    self.customers[name] = customer

@external
def saveNewCustomerFemale(name: String[50], table: String[50]):
    assert msg.sender == self.owner, "Esta funcion solo puede ser accedida por el owner"
    customer: Customer = Customer({name: name, table: table, gender: CustomerGender.FEMALE, status: CustomerStatus.NOT_ATTENDED})
    self.customers[name] = customer

@external
def saveNewCustomerOther(name: String[50], table: String[50]):
    assert msg.sender == self.owner, "Esta funcion solo puede ser accedida por el owner"
    customer: Customer = Customer({name: name, table: table, gender: CustomerGender.OTHER, status: CustomerStatus.NOT_ATTENDED})
    self.customers[name] = customer

@view
@external
def getCustomer(name: String[50]) -> Customer:
    custumer: Customer = self.customers[name] # busco en el HashMap el custumer con nombre name (porque esa es la key). custumer tipo Custumer
    assert custumer.name == name, "Cliente no encontrado"
    return custumer

@external
def changeStatus(name: String[50], status: CustomerStatus):
    customer: Customer = self.customers[name]
    assert customer.name == name, "Cliente no encontrado"
    customer.status = status

@external
def changeTable(name: String[50], table: String[50]):
    customer: Customer = self.customers[name]
    assert customer.name == name, "Cliente no encontrado"
    customer.table = table

@external
def setOrder(table: String[50], nameCustomer: String[50], receiverAddress: address):
    custumer: Customer = self.customers[nameCustomer] # busco en el HashMap el custumer con nombre name (porque esa es la key). custumer tipo Custumer
    assert custumer.name == nameCustomer, "Cliente no encontrado"
    order: Restaurant = Restaurant(receiverAddress)
    #order.saveNewOrder(table: table, customer: nameCustomer)
    order.saveNewOrder(table, nameCustomer)

