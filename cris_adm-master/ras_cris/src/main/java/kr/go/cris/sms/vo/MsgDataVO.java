package kr.go.cris.sms.vo;

import java.io.Serializable;

import kr.go.cris.commons.vo.CommonsVo;

import org.apache.ibatis.type.Alias;



/**
 * <pre>
 *  SMS Vo
 * 
 * </pre>
 * @FileName : MsgDataVO.java
 * @package  : kr.go.cris.ptl.sms.vo
 * @author   : user
 * @date     : 2018. 7. 4.
 * 
 */
@Alias("msgDataVO")
public class MsgDataVO extends CommonsVo  implements Serializable  {

	private static final long serialVersionUID = 7412901319304766681L;
	 
	/** MSG_SEQ */
    private java.math.BigDecimal msgSeq;
    
    /** REQ_DATE */
    private java.lang.String reqDate;
    
    /** CUR_STATE */
    private java.lang.String curState;
    
    /** CALL_TO */
    private java.lang.String callTo;
    
    /** CALL_FROM */
    private java.lang.String callFrom;
    
    /** SMS_TXT */
    private java.lang.String smsTxt;
    
    /** MSG_TYPE */
    private java.lang.String msgType;
    
    /** SUB_ID */
    private java.lang.String subId;
    
    public java.math.BigDecimal getMsgSeq() {
        return this.msgSeq;
    }
    
    public void setMsgSeq(java.math.BigDecimal msgSeq) {
        this.msgSeq = msgSeq;
    }
    
    public java.lang.String getReqDate() {
        return this.reqDate;
    }
    
    public void setReqDate(java.lang.String reqDate) {
        this.reqDate = reqDate;
    }
    
    public java.lang.String getCurState() {
        return this.curState;
    }
    
    public void setCurState(java.lang.String curState) {
        this.curState = curState;
    }
    
    public java.lang.String getCallTo() {
        return this.callTo;
    }
    
    public void setCallTo(java.lang.String callTo) {
        this.callTo = callTo;
    }
    
    public java.lang.String getCallFrom() {
        return this.callFrom;
    }
    
    public void setCallFrom(java.lang.String callFrom) {
        this.callFrom = callFrom;
    }
    
    public java.lang.String getSmsTxt() {
        return this.smsTxt;
    }
    
    public void setSmsTxt(java.lang.String smsTxt) {
        this.smsTxt = smsTxt;
    }
    
    public java.lang.String getMsgType() {
        return this.msgType;
    }
    
    public void setMsgType(java.lang.String msgType) {
        this.msgType = msgType;
    }
    
    public java.lang.String getSubId() {
        return this.subId;
    }
    
    public void setSubId(java.lang.String subId) {
        this.subId = subId;
    }
	
	
}
