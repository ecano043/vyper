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
    waiter: address
    chef: address
    custumer: address

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
def saveNewMenu(menu: Menu):
    self.menus[menu.name] = menu

@external
def changeStateOrder(table: String[50], status: OrderStatus):
    order: Order = self.orders[table]
    assert order.table == table, "Orden no encontrada"
    order.status = status

@external
def saveNewOrder(order: Order):
    self.orders[order.table] = order

@view
@external
def getOrder(table: String[50]) -> Order:
    order: Order = self.orders[table]
    assert order.waiter != empty(address), "No hay orden para esa mesa, pregunte al mesero"
    return order

@view
@external
def getMenu(name: String[50]) -> Menu:
    menu: Menu = self.menus[name]
    assert menu.name != "", "No existe ese plato en el menu"
    return menu