"use strict";
const STATE_REJECTED = -2;
const STATE_INVALID = -1;
const STATE_OPENED = 0;
const STATE_ACCEPTED = 1;
const STATE_IN_PROCESS = 2;
const STATE_DEAL = 3;
const STATE_COMPLETED = 4;


function captionByState(state) {
    switch (state) {
        case STATE_REJECTED : return "Отклонено";
        case STATE_INVALID : return "Некорректное";
        case STATE_OPENED : return "Свободно";
        case STATE_ACCEPTED : return "Принято";
        case STATE_IN_PROCESS : return "В процессе";
        case STATE_DEAL : return "В процессе";
        case STATE_COMPLETED : return "Завершено";
        default : return "";
    }
}

function progressBarByState(state) {

    if (state >= 0) {
        var color;
        var width;

        switch (state) {

            case STATE_OPENED : {
                color = 'progress-bar-info';
                width = '1%';
                break;
            }
            case STATE_ACCEPTED : {
                color = 'progress-bar-info';
                width = '20%';
                break;
            }
            case STATE_IN_PROCESS : {
                color = 'progress-bar-info';
                width = '45%';
                break;
            }
            case STATE_DEAL : {
                color = 'progress-bar-info';
                width = '70%';
                break;
            }
            case STATE_COMPLETED : {
                color = 'progress-bar-info';
                width = '100%';
                break;
            }

        }

        var progressBar = '<div class="progress progress-striped active" style="margin-bottom: 0">';
        progressBar += '<div class="progress-bar ' + color + '" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: ' + width + '"></div>';
        progressBar += '</div>';

        return progressBar;


    } else {
        var text;
        var color;
        var errorMessage = '';

        switch (state) {
            case STATE_REJECTED : {
                color = 'rejected_state';
                text = 'Отклонено';
                break;
            }
            case STATE_INVALID : {
                color = 'invalid_state';
                text = 'Некорректно';
                break;
            }
        }
        errorMessage = '<div><span class="' + color + '">' + text + '</span></div>';

        return errorMessage;
    }
}

function OrderBuilder(order, noImage, location) {
    this.order = order;
    this.noImage = noImage;
    this.location = location;
}

OrderBuilder.prototype.buildOrder = function () {
    var targetOrder = this.order;
    var noImage = this.noImage;
    var location = this.location;

    var orderPage = '';

    if (targetOrder != null) {
        var state = targetOrder.state;
        switch (state) {

            case STATE_REJECTED : {
                orderPage += buildCaption(targetOrder);
                orderPage += buildIcons(targetOrder);
                orderPage += addOrderInfo(targetOrder);
                orderPage += addAddressInfo(targetOrder, true);
                orderPage += addTable(targetOrder, noImage, location, false);
                orderPage += addSumInfo(targetOrder);
                orderPage += addCommentary(targetOrder, true);
                orderPage += addUnlockButton();
                break;
            }
            case STATE_INVALID : {
                orderPage += buildCaption(targetOrder);
                orderPage += buildIcons(targetOrder);
                orderPage += addOrderInfo(targetOrder);
                orderPage += addAddressInfo(targetOrder, true);
                orderPage += addTable(targetOrder, noImage, location, false);
                orderPage += addSumInfo(targetOrder);
                orderPage += addCommentary(targetOrder, true);
                orderPage += addUnlockButton();
                break;
            }
            case STATE_ACCEPTED : {
                orderPage += buildCaption(targetOrder);
                orderPage += buildIcons(targetOrder);
                orderPage += addOrderInfo(targetOrder);
                orderPage += addAddressInfo(targetOrder, true);
                orderPage += addTable(targetOrder, noImage, location, false);
                orderPage += addSumInfo(targetOrder);
                orderPage += addCommentary(targetOrder, false);
                orderPage += addValidationButtons();
                break;
            }
            case STATE_IN_PROCESS : {
                orderPage += buildCaption(targetOrder);
                orderPage += buildIcons(targetOrder);
                orderPage += addOrderInfo(targetOrder);
                orderPage += addTable(targetOrder, noImage, location, true);
                orderPage += addSumInfo(targetOrder);
                orderPage += addAddressInfo(targetOrder, false);
                orderPage += addDealDate(targetOrder, false);
                orderPage += addCommentary(targetOrder, false);
                orderPage += addConfirmationButtons();
                break;
            }
            case STATE_DEAL : {
                orderPage += buildCaption(targetOrder);
                orderPage += buildIcons(targetOrder);
                orderPage += addOrderInfo(targetOrder);
                orderPage += addTable(targetOrder, noImage, location, true);
                orderPage += addSumInfo(targetOrder);
                orderPage += addAddressInfo(targetOrder, true);
                orderPage += addDealDate(targetOrder, true);
                orderPage += addCommentary(targetOrder, false);
                orderPage += addCompletionButtons();
                break;
            }
            case STATE_COMPLETED : {
                orderPage += buildCaption(targetOrder);
                orderPage += buildIcons(targetOrder);
                orderPage += addOrderInfo(targetOrder);
                orderPage += addTable(targetOrder, noImage, location, false);
                orderPage += addSumInfo(targetOrder);
                orderPage += addAddressInfo(targetOrder, true);
                orderPage += addDealDate(targetOrder, true);
                orderPage += addCommentary(targetOrder, true);
                break;
            }
        }

    } else {
        orderPage += buildIcons(null);
        orderPage += buildField('Ф.И.О.', 'targetName', true, '');
        orderPage += buildField('E-mail', 'targetEmail', true, '');
        orderPage += buildField('Телефон', 'targetPhone', true, '');
        orderPage += buildField('Дата заказа', 'targetDateReceived', true, '');
    }

    return orderPage;
};

OrderBuilder.prototype.restartDatePicker = function () {

    var state = this.order.state;
    if (state == 2) {
        $('#datetimepicker2').datetimepicker({
            locale: 'ru'
        });
    }

};

function buildCaption(order) {
    var caption = '<div style="margin-top: 7px; font-size: 20px;">';
    var name = '';

    if (order != null) {
        switch (order.state) {

            case STATE_INVALID : {
                name = 'Некорректный заказ';
                break;
            }
            case STATE_REJECTED : {
                name = 'Заказ отклонен';
                break;
            }
            case STATE_ACCEPTED : {
                name = 'Валидация заказа';
                break;
            }
            case STATE_IN_PROCESS : {
                name = 'Установление контакта';
                break;
            }
            case STATE_DEAL : {
                name = 'Встреча';
                break;
            }
            case STATE_COMPLETED : {
                name = 'Сделка завершена';
                break;
            }
        }

    } else {
        name = 'Заказ не выбран';
    }

    caption += '<b>' + name + '</b>';
    caption += '</div>';
    return caption;

}

function getImgSrcByState(state) {

    switch (state) {

        case STATE_INVALID : {
            return "/pictures/order/valid_cancel.png";
        }
        case STATE_REJECTED : {
            return "/pictures/order/deal_cancel.png";
        }
        case STATE_ACCEPTED : {
            return "/pictures/order/valid.png";
        }
        case STATE_IN_PROCESS : {
            return "/pictures/order/phone.png";
        }
        case STATE_DEAL : {
            return "/pictures/order/deal.png";
        }
        case STATE_COMPLETED : {
            return "/pictures/order/money.png";
        }

        default : return '';
    }
}

function buildIcons(order) {

    var icons = '<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 xs_no_lr_padding" style="margin-top: 7px; margin-bottom: 14px">';

    if (order != null) {
        var state = order.state;

        switch (state) {

            case STATE_INVALID : {
                icons += '<img src="/pictures/order/valid_cancel.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                break;
            }
            case STATE_REJECTED : {
                icons += '<img src="/pictures/order/deal_cancel.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                break;
            }
            case STATE_ACCEPTED : {
                icons += '<img src="/pictures/order/valid.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/phone_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/deal_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/money_disabled.png" style="width: 20%; float: left">';
                break;
            }
            case STATE_IN_PROCESS : {
                icons += '<img src="/pictures/order/valid_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/phone.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/deal_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/money_disabled.png" style="width: 20%; float: left">';
                break;
            }
            case STATE_DEAL : {
                icons += '<img src="/pictures/order/valid_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/phone_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/deal.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/money_disabled.png" style="width: 20%; float: left">';
                break;
            }
            case STATE_COMPLETED : {
                icons += '<img src="/pictures/order/valid_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/phone_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/deal_disabled.png" style="width: 20%; float: left; margin-right: 6.66666%">';
                icons += '<img src="/pictures/order/money.png" style="width: 20%; float: left">';
                break;
            }

        }

    } else {
        icons += '<img src="/pictures/order/question.png" style="width: 20%; float: left">';
    }

    icons += '</div>';
    return icons;
}

function buildField(label, idName, disabled, value) {
    var field = '<label class="control-label">' + label + '</label>';
    var readOnly = (disabled == true) ? 'disabled="disabled"' : '';

    if (value == null) value = '';

    field += '<input id="' + idName + '" class="form-control space_bottom" ' + readOnly + ' value="' + value + '">';

    return field;
}

function addTable(order, noImage, location, edit) {
    var table = '<label class="control-label">Список товаров</label>';
    if (edit) {
        table += '<i class="fa fa-pencil" onclick="$(\'#editModal\').modal(\'toggle\');" style="margin-left : 6px; font-size: 15px; color: #525252; cursor: pointer;"></i>';
    }
    table += '<div class="table-responsive" style="font-size: 13px">';
    table += '<table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em" >';
    table += '<thead>';
    table += '<tr> <th style="text-align: center">#</th> <th></th> <th>Название</th> <th>Количество</th> <th>Сумма</th> </tr>';
    table += '</thead>';
    table += '<tbody id="productMain">';

    var products = order.products;

    for (var i = 0; i < products.length; i++) {
        var product = products[i];

        var id = product.id;
        var productId = (product.productId != null) ? product.productId : '';
        var name = product.name;
        var price = product.price;
        var count = product.count;
        var sum = (count * price).toFixed(2);

        var row = '<tr style="height: 60px">';

        row += '<td style="vertical-align: middle; text-align: center">' + productId + '</td>';

        var imgSrc = (product.preview == '') ? noImage : ( location + product.preview );
        var imgElem = '<a href="/' + product.type + '/' + ( (productId != '') ? productId : '-1' ) + '"><img src=' + imgSrc + ' style="max-width:36px; max-height: 42px"></a>';
        row += '<td class="text-center" style="vertical-align: middle">' + imgElem + '</td>';

        row += '<td style="vertical-align: middle">' + name + '</td>';
        row += '<td style="vertical-align: middle">' + count + '</td>';
        row += '<td style="vertical-align: middle">' + sum + ' руб.</td>';

        row += '</tr>';

        table += row;
    }

    table += '</tbody></table></div>';

    return table;
}

function addOrderInfo(order) {
    var orderInfo = '<input type="hidden" id="targetId" class="form-control space_bottom" disabled="disabled" value="' + order.id + '">';
    orderInfo += buildField('Ф.И.О.', 'targetName', true, order.name);
    orderInfo += buildField('E-mail', 'targetEmail', true, order.email);
    orderInfo += buildField('Телефон', 'targetPhone', true, order.phone);
    orderInfo += buildField('Дата заказа', 'targetDateReceived', true, order.dateReceived);

    return orderInfo;
}

function addAddressInfo(order, disabled) {
    var addressInfo = buildField('Адрес доставки', 'targetAddress', disabled, order.meetingPoint);
    return addressInfo;
}

function addSumInfo(order) {
    var sumInfo = buildField('Сумма', 'targetTotalSum', true, (order.totalSum).toFixed(2) + ' руб.');
    return sumInfo;
}

function addCommentary(order, disabled) {
    var commentary = (order.commentary == null) ? '' : order.commentary;
    var readOnly = (disabled == true) ? 'disabled="disabled"' : '';

    var commentaryArea = '<label class="control-label">Комментарий</label><textarea id="targetCommentary" ' + readOnly + ' class="form-control space_bottom" rows="5" style="resize: vertical">' + commentary + '</textarea>';

    return commentaryArea;
}

function addValidationButtons() {
    var validationButtons = '<div class="pull-right" style="display: inline-block; margin-top: 3px">';
    validationButtons += '<button type="button" onclick="setValidDecision(true)" class="btn btn-primary space_bottom" style="margin-right: 5px"> <i class="fa fa-check"> Корректен</i> </button>';
    validationButtons += '<button type="button" onclick="setValidDecision(false)" class="btn btn-default space_bottom"> <i class="fa fa-times"> Некорректен</i> </button>';
    validationButtons += '</div>';

    return validationButtons;
}

function addConfirmationButtons() {
    var confirmButtons = '<div class="pull-right" style="display: inline-block; margin-top: 3px">';
    confirmButtons += '<button type="button" onclick="assignDeal()" class="btn btn-primary space_bottom" style="margin-right: 5px"> <i class="fa fa-clock-o"> Назначить</i> </button>';
    confirmButtons += '<button type="button" onclick="rejectDeal()" class="btn btn-default space_bottom"> <i class="fa fa-times"> Отказ от сделки</i> </button>';
    confirmButtons += '</div>';

    return confirmButtons;
}

function addCompletionButtons() {
    var completionButtons = '<div class="pull-right" style="display: inline-block; margin-top: 3px">';
    completionButtons += '<button type="button" onclick="finishDeal()" class="btn btn-primary space_bottom" style="margin-right: 5px"> <i class="fa fa-check"> Завершить</i> </button>';
    completionButtons += '<button type="button" onclick="deferDeal()" class="btn btn-default space_bottom" style="margin-right: 5px"> <i class="fa fa-clock-o"> Отложить</i> </button>';
    completionButtons += '<button type="button" onclick="rejectDeal()" class="btn btn-default space_bottom"> <i class="fa fa-times"> Отказ от сделки</i> </button>';
    completionButtons += '</div>';

    return completionButtons;
}

function addUnlockButton() {
    var unlockButton = '<div class="pull-right" style="display: inline-block; margin-top: 3px">';
    unlockButton += '<button type="button" onclick="unlockOrder()" class="btn btn-primary space_bottom"> <i class="fa fa-unlock-alt"> Разблокировать</i> </button>';
    unlockButton += '</div>';

    return unlockButton;
}

function setValidDecision(decision) {

    var id = $('#targetId').val();
    var commentary = $('#targetCommentary').val();

    $.ajax({
        type : "POST",
        url : "/management/orders/valid/",
        data : { decision : decision, id : id, commentary : commentary},
        dataType : 'json',
        timeout : 100000,
        success : function(result) {

            if (result != null) {

                if (result == true) {

                    var targetOrder = null;
                    for (var i = 0; i < orders.length; i++) {
                        var order = orders[i];
                        if (order.id == id) {
                            order.state = (decision) ? STATE_IN_PROCESS : STATE_INVALID;
                            order.commentary = commentary;

                            targetOrder = order;
                            break;
                        }
                    }

                    buildOrder(targetOrder);
                    addOrderToReminders(targetOrder);
                    updateState(targetOrder.id, targetOrder.state);
                }

            }

        },
        error : function(e) {
            console.log("ERROR: ", e);
        }

    });

}

function assignDeal() {

    var id = $('#targetId').val();
    var address = $('#targetAddress').val();
    var dealDate = $('#targetDealDate').val();
    var commentary = $('#targetCommentary').val();

    $.ajax({
        type : "POST",
        url : "/management/orders/assign/",
        data : { id : id, address : address, dealDate : dealDate, commentary : commentary},
        dataType : 'json',
        timeout : 100000,
        success : function(result) {

            if (result != null) {

                var element = '#message';
                var bodyHeight = $('html > body').height();
                var caption = 'Уведомление';
                var content = result.message;
                showMessage(element, bodyHeight, caption, content);

                if (result.success == true) {

                    var targetOrder = null;
                    for (var i = 0; i < orders.length; i++) {
                        var order = orders[i];
                        if (order.id == id) {
                            order.state = STATE_DEAL;
                            order.meetingPoint = address;
                            order.dateDeal = dealDate;
                            order.commentary = commentary;

                            targetOrder = order;
                            break;
                        }
                    }
                    buildOrder(targetOrder);
                    addOrderToReminders(targetOrder);
                    updateState(targetOrder.id, targetOrder.state);
                }
            }

        },
        error: function(e) {
            console.log(e);
        }

    });

}

function finishDeal() {

    var id = $('#targetId').val();
    var commentary = $('#targetCommentary').val();

    $.ajax({
        type : "POST",
        url : "/management/orders/finish/",
        data : { id : id, commentary : commentary},
        dataType : 'json',
        timeout : 100000,
        success : function(result) {

            if (result != null) {
                var element = '#message';
                var bodyHeight = $('html > body').height();
                var caption = 'Уведомление';
                var content = result.message;

                showMessage(element, bodyHeight, caption, content);

                if (result.success == true) {

                    var targetOrder = null;
                    for (var i = 0; i < orders.length; i++) {
                        var order = orders[i];
                        if (order.id == id) {
                            order.state = STATE_COMPLETED;
                            order.commentary = commentary;

                            targetOrder = order;
                            break;
                        }
                    }
                    buildOrder(targetOrder);
                    addOrderToReminders(targetOrder);
                    updateState(targetOrder.id, targetOrder.state);
                }

            }

        },
        error: function(e) {
            console.log(e);
        }

    });

}
function deferDeal() {

    var id = $('#targetId').val();
    var commentary = $('#targetCommentary').val();

    $.ajax({
        type : "POST",
        url : "/management/orders/defer/",
        data : { id : id, commentary : commentary},
        dataType : 'json',
        timeout : 100000,
        success : function(result) {

            if (result != null) {
                var element = '#message';
                var bodyHeight = $('html > body').height();
                var caption = 'Уведомление';
                var content = result.message;

                showMessage(element, bodyHeight, caption, content);

                if (result.success == true) {

                    var targetOrder = null;
                    for (var i = 0; i < orders.length; i++) {
                        var order = orders[i];
                        if (order.id == id) {
                            order.state = STATE_IN_PROCESS;
                            order.commentary = commentary;

                            targetOrder = order;
                            break;
                        }
                    }
                    buildOrder(targetOrder);
                    addOrderToReminders(targetOrder);
                    updateState(targetOrder.id, targetOrder.state);
                }

            }

        },
        error: function(e) {
            console.log(e);
        }

    });

}

function rejectDeal() {
    $('#reasonModal').modal('toggle');
}

function unlockOrder() {

    var id = $('#targetId').val();

    $.ajax({
        type : "POST",
        url : "/management/orders/unlock/",
        data : { id : id},
        dataType : 'json',
        timeout : 100000,
        success : function(result) {

            if (result != null) {
                var element = '#message';
                var bodyHeight = $('html > body').height();
                var caption = 'Уведомление';
                var content = result.message;

                showMessage(element, bodyHeight, caption, content);

                if (result.success == true) {

                    var targetOrder = null;
                    for (var i = 0; i < orders.length; i++) {
                        var order = orders[i];
                        if (order.id == id) {
                            order.state = STATE_IN_PROCESS;

                            targetOrder = order;
                            break;
                        }
                    }
                    buildOrder(targetOrder);
                    addOrderToReminders(targetOrder);
                    updateState(targetOrder.id, targetOrder.state);
                }

            }

        },
        error: function(e) {
            console.log(e);
        }

    });

}

function addDealDate(order, disabled) {
    var readOnly = (disabled == true) ? 'disabled="disabled"' : '';

    var dealDate = '<label class="control-label">Дата сделки</label>';

    dealDate += '<div class="form-group">';
    dealDate +=   '<div class="input-group date" id="datetimepicker2">';
    dealDate +=     '<input type="text" id="targetDealDate" ' + readOnly + ' class="form-control" value="' + order.dateDeal + '"/>';
    dealDate +=     '<span class="input-group-addon">';
    dealDate +=       '<span class="fa fa-clock-o"></span>';
    dealDate +=     '</span>';
    dealDate +=   '</div>';
    dealDate += '</div>';

    return dealDate;
}

