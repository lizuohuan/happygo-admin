$(function () {
    $("#subFrom").bootstrapValidator({
        message:'This value is not valid',
//            定义未通过验证的状态图标
        feedbackIcons: {/*输入框不同状态，显示图片的样式*/
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
//            字段验证
        fields:{
//                用户名
            name:{
                message:'分类名非法',
                validators:{
//                        非空
                    notEmpty:{
                        message:'分类名不能为空'
                    },
//                        限制字符串长度
                    stringLength:{
                        min:3,
                        max:20,
                        message:'用户名长度必须位于3到20之间'
                    },
//                        基于正则表达是的验证
                    regexp:{
                        regexp:/^[a-zA-Z0-9_\.]+$/,
                        message:'用户名由数字字母下划线和.组成'
                    }
                }
            },

//                密码
            password:{
                message:'密码非法',
                validators:{
                    notEmpty:{
                        message:'密码不能为空'
                    },
//                        限制字符串长度
                    stringLength:{
                        min:3,
                        max:20,
                        message:'密码长度必须位于3到20之间'
                    },
//                        相同性检测
                    identical:{
//                            需要验证的field
                        field:'password',
                        message:'两次密码输入不一致'
                    },
//                        基于正则表达是的验证
                    regexp:{
                        regexp:/^[a-zA-Z0-9_\.]+$/,
                        message:'密码由数字字母下划线和.组成'
                    }
                }
            },

            //                确认密码
            repassword:{
                message:'密码非法',
                validators:{
                    notEmpty:{
                        message:'密码不能为空'
                    },
//                        限制字符串长度
                    stringLength:{
                        min:3,
                        max:20,
                        message:'密码长度必须位于3到20之间'
                    },
//                        相同性检测
                    identical:{
//                            需要验证的field
                        field:'password',
                        message:'两次密码输入不一致'
                    },
//                        基于正则表达是的验证
                    regexp:{
                        regexp:/^[a-zA-Z0-9_\.]+$/,
                        message:'密码由数字字母下划线和.组成'
                    }
                }
            },

//                电子邮箱
            email:{
                validators:{
                    notEmpty:{
                        message:'邮箱地址不能为空'
                    },
                    emailAddress:{
                        message:'请输入正确的邮箱地址'
                    }
                }
            },

//                手机号码
            phone:{
                validators:{
                    notEmpty:{
                        message:'手机号码不能为空'
                    },
                    stringlength:{
                        min:11,
                        max:11,
                        message:'请输入11位手机号码'
                    },
                    regexp:{
                        regexp:/^1[3|5|8]{1}[0-9]{9}$/,
                        message:'请输入正确的手机号码'
                    }
                }
            },

//                邀请码
            inviteCode:{
                validators:{
                    notEmpty:{
                        message:'邀请码不能为空'
                    },
                    stringlength:{
                        min:9,
                        max:9,
                        message:'请输入9位邀请码'
                    },
                    regexp:{
                        regexp:/^[\w]{8}$/,
                        message:'邀请码由数字和字母组成'
                    }
                }
            }
        }
    })
})