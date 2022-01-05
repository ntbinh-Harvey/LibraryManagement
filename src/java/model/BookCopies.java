/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Date;

/**
 *
 * @author HarveyNguyen
 */
public class BookCopies extends Book {

    private int barcode;
    private String status;
    private Date purchaseDate;
    private int callCardId;
    private int returningCallCardId;
    private int bookId;

    public BookCopies() {
        super();
    }

    public int getBarcode() {
        return barcode;
    }

    public void setBarcode(int barcode) {
        this.barcode = barcode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public int getCallCardId() {
        return callCardId;
    }

    public void setCallCardId(int callCardId) {
        this.callCardId = callCardId;
    }

    public int getReturningCallCardId() {
        return returningCallCardId;
    }

    public void setReturningCallCardId(int returningCallCardId) {
        this.returningCallCardId = returningCallCardId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

}
