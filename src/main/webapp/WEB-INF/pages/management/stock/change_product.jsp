<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<select id="current_product" class="form-control">
    <option ${type == 'mobile' ? 'selected' : ''} value="mobile">Мобильные телефоны</option>
    <option ${type == 'notebook' ? 'selected' : ''} value="notebook">Ноутбуки</option>
</select>


