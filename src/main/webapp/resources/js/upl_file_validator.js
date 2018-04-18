function resetFileValidators() {
    $('input:file').bind('change', function() {

        var size = this.files[0].size/1024/1024;

        var filePath = $(this).val();

        if(!filePath.match(/\.(jpg|jpeg|png)$/i)) {
            showMSG('Уведомление', 'Недопустимый <b>формат</b> файла! [jpg|jpeg|png]');
            deleteFile($(this));
            return;
        }

        if (size > 2) {
            showMSG('Уведомление', 'Превышен <b>максимальный размер</b> файла! [2MB]');
            deleteFile($(this));
        }
    });
}
resetFileValidators();

function deleteFile(element) {
    resetPreviewByValidator( $(element).attr('id') );
    $(element).wrap('<form>').closest('form').get(0).reset();
    $(element).unwrap();
}

function showMSG(caption, content) {
    var element = '#message';
    var bodyHeight = $('html > body').height();

    showMessage(element, bodyHeight, caption, content);
}