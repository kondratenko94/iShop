package com.springapp.mvc.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class SaleDto {

    private BigDecimal totalSum;

    private String dateDeal;

    public BigDecimal getTotalSum() {
        return totalSum;
    }

    public void setTotalSum(BigDecimal totalSum) {
        this.totalSum = totalSum;
    }

    public String getDateDeal() {
        return dateDeal;
    }

    public void setDateDeal(String dateDeal) {
        this.dateDeal = dateDeal;
    }

    public void setDateDeal(Timestamp dateTime) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        this.dateDeal = dateFormat.format(dateTime);
    }
}