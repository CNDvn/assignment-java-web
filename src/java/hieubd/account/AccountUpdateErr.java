/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieubd.account;

import java.io.Serializable;

/**
 *
 * @author CND
 */
public class AccountUpdateErr implements Serializable{
    private String passwordErrLength;

    public AccountUpdateErr() {
    }

    public String getPasswordErrLength() {
        return passwordErrLength;
    }

    public void setPasswordErrLength(String passwordErrLength) {
        this.passwordErrLength = passwordErrLength;
    }
    
}
