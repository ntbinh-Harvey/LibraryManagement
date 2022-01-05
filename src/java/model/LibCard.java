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
public class LibCard {
    private int cardId;
    private Date exp_date;
    private Reader r;

    public LibCard() {
    }

    public LibCard(int cardId, Date exp_date, Reader r) {
        this.cardId = cardId;
        this.exp_date = exp_date;
        this.r = r;
    }

    public int getCardId() {
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public Date getExp_date() {
        return exp_date;
    }

    public void setExp_date(Date exp_date) {
        this.exp_date = exp_date;
    }

    public Reader getR() {
        return r;
    }

    public void setR(Reader r) {
        this.r = r;
    }
    
    
}
