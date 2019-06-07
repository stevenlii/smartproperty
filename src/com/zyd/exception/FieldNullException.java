package com.zyd.exception;
/**
 * 自定义异常，字段为空时需要抛出此异常
 * @author lzq
 *
 */
public class FieldNullException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public FieldNullException() {
		super();
	}

	public FieldNullException(String msg) {
		super(msg);
	}

	public FieldNullException(String msg, Throwable cause) {
		super(msg, cause);
	}

	public FieldNullException(Throwable cause) {
		super(cause);
	}
}
