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
public class User {

    private int id;
    private String username;
    private String password;
    private String fullname;
    private Date DoB;
    private String address;
    private String telephone;
    private String email;
    private String role;
    private String description;

    public User() {
    }

    public User(int id, String username) {
        this.id = id;
        this.username = username;
    }

    public User(String fullname, Date DoB, String address, String telephone, String email) {
        this.fullname = fullname;
        this.DoB = DoB;
        this.address = address;
        this.telephone = telephone;
        this.email = email;
    }

    public User(int id, String fullname, Date DoB, String address, String telephone, String email) {
        this.id = id;
        this.fullname = fullname;
        this.DoB = DoB;
        this.address = address;
        this.telephone = telephone;
        this.email = email;
    }
    
    

    public User(int id, String username, String fullname, Date DoB, String address, String telephone, String email, String role) {
        this.id = id;
        this.username = username;
        this.fullname = fullname;
        this.DoB = DoB;
        this.address = address;
        this.telephone = telephone;
        this.email = email;
        this.role = role;
    }

    public User(int id, String username, String password, String fullname, Date DoB, String address, String telephone, String email, String role, String description) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.DoB = DoB;
        this.address = address;
        this.telephone = telephone;
        this.email = email;
        this.role = role;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Date getDoB() {
        return DoB;
    }

    public void setDoB(Date DoB) {
        this.DoB = DoB;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
