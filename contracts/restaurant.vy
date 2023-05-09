# @version ^0.3.7

enum OrderStatus:
    ENQUEUED
    IN_PREPARATION
    COOCKED
    SERVED

enum MenuType:
    STARTER
    MAIN_COURSE
    DESSERT
    DRINK

owner: address

struct Order:
    status: OrderStatus
    menuType: MenuType
    table: String[50]
    customer: String[50]

struct Menu:
    name: String[50]
    menuType: MenuType
    price: uint256

menus: HashMap[String[50], Menu]
orders: HashMap[String[50], Order]

@external
def __init__():
    self.owner = msg.sender

@external
def saveNewMenuStarter(name: String[50], price: uint256):
    assert msg.sender == self.owner, "Esta funcion solo puede ser accedida por el owner"
    menu: Menu = Menu({name: name, menuType: MenuType.STARTER, price: price})
    self.menus[name] = menu

@external
def saveNewMenuMainCourse(name: String[50], price: uint256):
    assert msg.sender == self.owner, "Esta funcion solo puede ser accedida por el owner"
    menu: Menu = Menu({name: name, menuType: MenuType.MAIN_COURSE, price: price})
    self.menus[name] = menu

@external
def saveNewMenuDessert(name: String[50], price: uint256):
    assert msg.sender == self.owner, "Esta funcion solo puede ser accedida por el owner"
    menu: Menu = Menu({name: name, menuType: MenuType.DESSERT, price: price})
    self.menus[name] = menu

@external
def saveNewMenuDrink(name: String[50], price: uint256):
    assert msg.sender == self.owner, "Esta funcion solo puede ser accedida por el owner"
    menu: Menu = Menu({name: name, menuType: MenuType.DRINK, price: price})
    self.menus[name] = menu

@external
def changeStateOrder(table: String[50], status: OrderStatus):
    order: Order = self.orders[table]
    assert order.table == table, "Orden no encontrada"
    order.status = status

@external
def saveNewOrder(table: String[50], name: String[50]):
    order: Order = Order({status: OrderStatus.ENQUEUED, menuType: MenuType.MAIN_COURSE, table: table, customer: name})
    self.orders[table] = order

@view
@external
def getOrder(table: String[50]) -> Order:
    order: Order = self.orders[table]
    assert order.customer != empty(String[50]), "No hay cliente para esa mesa, pregunte al mesero"
    return order

@view
@external
def getMenu(name: String[50]) -> Menu:
    menu: Menu = self.menus[name]
    assert menu.name != "", "No existe ese plato en el menu"
    return menu