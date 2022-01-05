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
public class CallCard {

    private int id;
    private Date borrowingDate;
    private Date dueDate;
    private LibCard borrower;
    private Librarian librarian;
    private ArrayList<BookCopies> lb;

    public CallCard() {
    }

    public CallCard(int id, Date borrowingDate, Date dueDate, LibCard borrower, Librarian librarian, ArrayList<BookCopies> lb) {
        this.id = id;
        this.borrowingDate = borrowingDate;
        this.dueDate = dueDate;
        this.borrower = borrower;
        this.librarian = librarian;
        this.lb = lb;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getBorrowingDate() {
        return borrowingDate;
    }

    public void setBorrowingDate(Date borrowingDate) {
        this.borrowingDate = borrowingDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public LibCard getBorrower() {
        return borrower;
    }

    public void setBorrower(LibCard borrower) {
        this.borrower = borrower;
    }

    public ArrayList<BookCopies> getLb() {
        return lb;
    }

    public void setLb(ArrayList<BookCopies> lb) {
        this.lb = lb;
    }

    public Librarian getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian librarian) {
        this.librarian = librarian;
    }
    

}
