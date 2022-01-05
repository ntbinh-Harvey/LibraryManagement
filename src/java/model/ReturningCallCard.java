/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author HarveyNguyen
 */
public class ReturningCallCard {
    private int id;
    private float fine;
    private Date returningDate;
    private LibCard borrower;
    private Librarian librarian;
    private ArrayList<BookCopies> lb;

    public ReturningCallCard() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getFine() {
        return fine;
    }

    public void setFine(float fine) {
        this.fine = fine;
    }

    public Date getReturningDate() {
        return returningDate;
    }

    public void setReturningDate(Date returningDate) {
        this.returningDate = returningDate;
    }

    public LibCard getBorrower() {
        return borrower;
    }

    public void setBorrower(LibCard borrower) {
        this.borrower = borrower;
    }

    public Librarian getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian librarian) {
        this.librarian = librarian;
    }

    public ArrayList<BookCopies> getLb() {
        return lb;
    }

    public void setLb(ArrayList<BookCopies> lb) {
        this.lb = lb;
    }
    
    
}
