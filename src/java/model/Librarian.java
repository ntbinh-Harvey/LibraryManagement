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
public class Librarian extends User{

    public Librarian() {
    }

    public Librarian(int id, String username) {
        super(id, username);
    }

    public Librarian(String fullname, Date DoB, String address, String telephone, String email) {
        super(fullname, DoB, address, telephone, email);
    }

    public Librarian(int id, String fullname, Date DoB, String address, String telephone, String email) {
        super(id, fullname, DoB, address, telephone, email);
    }

    public Librarian(int id, String username, String fullname, Date DoB, String address, String telephone, String email, String role) {
        super(id, username, fullname, DoB, address, telephone, email, role);
    }

    public Librarian(int id, String username, String password, String fullname, Date DoB, String address, String telephone, String email, String role, String description) {
        super(id, username, password, fullname, DoB, address, telephone, email, role, description);
    }
    
}
