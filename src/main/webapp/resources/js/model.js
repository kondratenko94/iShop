
function Product(id, type, caption, name, link, price) {
    this.id = id;
    this.type = type;
    this.caption = caption;
    this.name = name;
    this.link = link;
    this.price = price;
}

function ProductMin(id, type) {
    this.id = id;
    this.type = type;
}

function Message(message, success) {
    this.message = message;
    this.success = success;
}

function Image(id, productType, link, file, position) {
    this.id = id;
    this.productType = productType;
    this.link = link;
    this.file = file;
    this.position = position;
}

function User(username, name, patronymic , surname, phone, email, address, photo, group, status) {
    this.username = username;
    this.name = name;
    this.surname = surname;
    this.phone = phone;
    this.email = email;
    this.patronymic = patronymic;
    this.address = address;
    this.photo = photo;
    this.group = group;
    this.status = status;
}

function Order(id, email, phone, name, dateReceived, state, commentary, meetingPoint, dateDeal, totalSum, managerPhoto, manager, products) {

    this.id = id;
    this.email = email;
    this.phone = phone;
    this.name = name;
    this.dateReceived = dateReceived;
    this.state = state;
    this.commentary = commentary;
    this.meetingPoint = meetingPoint;
    this.dateDeal = dateDeal;
    this.totalSum = totalSum;
    this.managerPhoto = managerPhoto;
    this.manager = manager;
    this.products = products;

    this.dateAccepted = '';
}

function Item(id, name, count, price, productId, type, preview) {

    this.id = id;
    this.name = name;
    this.count = count;
    this.price = price;
    this.productId = productId;
    this.type = type;
    this.preview = preview;

}

function UserSales(username, photo, name, surname, patronymic, quantity, totalSum) {
    this.username = username;
    this.photo = photo;
    this.name = name;
    this.surname = surname;
    this.patronymic = patronymic;
    this.quantity = quantity;
    this.totalSum = totalSum;
}

function ProductSales(id, preview, type, name, quantity, totalSum) {
    this.id = id;
    this.preview = preview;
    this.type = type;
    this.name = name;
    this.quantity = quantity;
    this.totalSum = totalSum;
}

function Sale(totalSum, dateDeal) {
    this.totalSum = totalSum;
    this.dateDeal = dateDeal;
}
