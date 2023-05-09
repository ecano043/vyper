# @version ^0.3.7

enum CustumerGender:
    MALE
    FEMALE
    OTHER

enum CustumerStatus:
    ATTENDED
    NOT_ATTENDED
    CHARGED

owner: address

struct Custumer:
    name: String[50]
    table: String[50]
    gender: CustumerGender
    status: CustumerStatus

custumers: HashMap[String[50], Custumer]

@external
def __init__():
    self.owner = msg.sender

@external
def saveNewCustumer(custumer: Custumer):
    self.custumers[custumer.name] = custumer

@view
@external
def getCustumer(name: String[50]) -> Custumer:
    custumer: Custumer = self.custumers[name] # busco en el HashMap el custumer con nombre name (porque esa es la key). custumer tipo Custumer
    assert custumer.name == name, "Cliente no encontrado"
    return custumer

@external
def changeStatus(name: String[50], status: CustumerStatus):
    custumer: Custumer = self.custumers[name]
    assert custumer.name == name, "Cliente no encontrado"
    custumer.status = status

@external
def changeTable(name: String[50], table: String[50]):
    custumer: Custumer = self.custumers[name]
    assert custumer.name == name, "Cliente no encontrado"
    custumer.table = table