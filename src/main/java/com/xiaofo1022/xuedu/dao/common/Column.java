package com.xiaofo1022.xuedu.dao.common;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Column {
	String value() default "";
	boolean isImage() default false;
	boolean isFormatDate() default false;
	boolean isFormatDatetime() default false;
	boolean isOrderNo() default false;
}
