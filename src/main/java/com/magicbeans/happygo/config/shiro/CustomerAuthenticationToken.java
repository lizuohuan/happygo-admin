package com.magicbeans.happygo.config.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;

public class CustomerAuthenticationToken extends UsernamePasswordToken {

    private String loginType;

    public CustomerAuthenticationToken(final String username, final String password, String loginType) {
        super(username,password);
        this.loginType = loginType;
    }

    public String getLoginType() {
        return loginType;
    }

    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }
}
