<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.nicepay.module.lite.NicePayWebConnector"%>
<%@ page import="com.bs.models.PayHistVO" %>
<%@ page import="com.bs.payment.PaymentService" %>
<%
request.setCharacterEncoding("euc-kr"); 

/*
*******************************************************
* <���� ��� ����>
* ����� ��� �ɼ��� ����� ȯ�濡 �µ��� �����ϼ���.
* �α� ���丮�� �� �����ϼ���.
*******************************************************
*/
NicePayWebConnector connector = new NicePayWebConnector();
// String nicePayHome = "C:/workspace/server/tomcat_8.0/webapps/ROOT/NICEPAY_Lite_JSP/WEB-INF/";   // ��� WEB-INF Path ����
String nicePayHome = request.getSession().getServletContext().getRealPath("/WEB-INF/");
String requestMid = request.getParameter("MID");

connector.setNicePayHome(nicePayHome);                              // �α� ���丮 ����
connector.setRequestData(request);                                  // ��û ������ �Ķ���� ����
connector.addRequestData("MID", requestMid);                        // �������̵�
connector.addRequestData("actionType", "PY0");                      // ���񽺸�� ����(���� ���� : PY0 , ��� ���� : CL0)
connector.addRequestData("MallIP", request.getRemoteAddr());        // ���� ���� ip
connector.addRequestData("CancelPwd", "123456");                    // ��� ��й�ȣ
connector.requestAction();

/*
*******************************************************
* <���� ��� �ʵ�>
* �Ʒ� ���� ������ �ܿ��� ���� Header�� ������ ������ Get ����
*******************************************************
*/
PayHistVO payHistVO = new PayHistVO();
payHistVO.setResult_code(connector.getResultData("ResultCode"));
payHistVO.setResult_msg(connector.getResultData("ResultMsg"));
payHistVO.setAuth_date(connector.getResultData("AuthDate"));
payHistVO.setAuth_code(connector.getResultData("AuthCode"));
payHistVO.setBuyer_name(connector.getResultData("BuyerName"));
payHistVO.setMall_user_id(connector.getResultData("MallUserID"));
payHistVO.setPay_method(connector.getResultData("PayMethod"));
payHistVO.setMid(connector.getResultData("MID"));
payHistVO.setTid(connector.getResultData("TID"));
payHistVO.setMoid(connector.getResultData("Moid"));
payHistVO.setAmt(connector.getResultData("Amt"));
payHistVO.setGoods_name(connector.getResultData("GoodsName"));
payHistVO.setCard_code(connector.getResultData("CardCode"));
payHistVO.setCard_name(connector.getResultData("CardName"));
payHistVO.setCard_quota(connector.getResultData("CardQuota"));
payHistVO.setBank_code(connector.getResultData("BankCode"));
payHistVO.setBank_name(connector.getResultData("BankName"));
payHistVO.setRcpt_type(connector.getResultData("RcptType"));
payHistVO.setRcpt_auth_code(connector.getResultData("RcptAuthCode"));
payHistVO.setRcpt_tid(connector.getResultData("RcptTID"));
payHistVO.setCarrier(connector.getResultData("Carrier"));
payHistVO.setDst_addr(connector.getResultData("DstAddr"));
payHistVO.setVbank_bank_code(connector.getResultData("VbankBankCode"));
payHistVO.setVbank_bank_name(connector.getResultData("VbankBankName"));
payHistVO.setVbank_num(connector.getResultData("VbankNum"));
payHistVO.setVbank_exp_date(connector.getResultData("VbankExpDate"));


String resultCode    = connector.getResultData("ResultCode");       // ����ڵ� (���� ����ڵ�:3001)
// String resultMsg     = connector.getResultData("ResultMsg");        // ����޽���
// String authDate      = connector.getResultData("AuthDate");         // �����Ͻ� (YYMMDDHH24mmss)
// String authCode      = connector.getResultData("AuthCode");         // ���ι�ȣ
// String buyerName     = connector.getResultData("BuyerName");        // �����ڸ�
// String mallUserID    = connector.getResultData("MallUserID");       // ȸ�����ID
String payMethod     = connector.getResultData("PayMethod");        // ��������
// String mid           = connector.getResultData("MID");              // ����ID
// String tid           = connector.getResultData("TID");              // �ŷ�ID
// String moid          = connector.getResultData("Moid");             // �ֹ���ȣ
// String amt           = connector.getResultData("Amt");              // �ݾ�
// String goodsName     = connector.getResultData("GoodsName");        // �ݾ�
// String cardCode      = connector.getResultData("CardCode");         // ī��� �ڵ�
// String cardName      = connector.getResultData("CardName");         // ����ī����
// String cardQuota     = connector.getResultData("CardQuota");        // ī�� �Һΰ��� (00:�Ͻú�,02:2����)
// String bankCode      = connector.getResultData("BankCode");         // ���� �ڵ�
// String bankName      = connector.getResultData("BankName");         // �����
// String rcptType      = connector.getResultData("RcptType");         // ���� ������ Ÿ�� (0:�����������,1:�ҵ����,2:��������)
// String rcptAuthCode  = connector.getResultData("RcptAuthCode");     // ���ݿ����� ���� ��ȣ
// String rcptTID       = connector.getResultData("RcptTID");          // ���� ������ TID   
// String carrier       = connector.getResultData("Carrier");          // ����籸��
// String dstAddr       = connector.getResultData("DstAddr");          // �޴�����ȣ
// String vbankBankCode = connector.getResultData("VbankBankCode");    // ������������ڵ�
// String vbankBankName = connector.getResultData("VbankBankName");    // ������������
// String vbankNum      = connector.getResultData("VbankNum");         // ������¹�ȣ
// String vbankExpDate  = connector.getResultData("VbankExpDate");     // ��������Աݿ�����



/*
*******************************************************
* <���� ���� ���� Ȯ��>
*******************************************************
*/
boolean paySuccess = false;
if(payMethod.equals("CARD")){
	if(resultCode.equals("3001")) {
		paySuccess = true;	            // �ſ�ī��(���� ����ڵ�:3001)
	}
}else if(payMethod.equals("BANK")){
	if(resultCode.equals("4000")) paySuccess = true;	            // ������ü(���� ����ڵ�:4000)	
}else if(payMethod.equals("CELLPHONE")){
	if(resultCode.equals("A000")) paySuccess = true;	            // �޴���(���� ����ڵ�:A000)
}else if(payMethod.equals("VBANK")){	
	if(resultCode.equals("4100")) paySuccess = true;	            // �������(���� ����ڵ�:4100)
}

/*
*******************************************************
* k.park <���� ���� �� ������ �÷ο�>
*******************************************************
*/
if(paySuccess == true){
	PaymentService paymentService = new PaymentService();
	paymentService.insertPayHist(payHistVO);	
}
%>
<!DOCTYPE html>
<html>
<head>
<title>NICEPAY PAY RESULT</title>
<meta charset="euc-kr">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/payment/import.css"/>
</head>
<body> 
  <div class="payfin_area">
    <div class="top">���� ��� ����</div>
    <div class="conwrap">
      <div class="con">
        <div class="tabletypea">
          <table>
            <colgroup><col width="30%"/><col width="*"/></colgroup>
              <td>
                <tr>
                  <th><span>��� ����</th>
                  <td>[<%=resultCode%>]<%=resultMsg%></td>
                </tr>
                <tr>
                  <th><span>���� ����</th>
                  <td><%=payMethod%></td>
                </tr>
                <tr>
                  <th><span>��ǰ��</th>
                  <td><%=goodsName%></td>
                </tr>
                <tr>
                  <th><span>�ݾ�</th>
                  <td><%=amt%>��</td>
                </tr>
                <tr>
                  <th><span>�ŷ����̵�</th>
                  <td><%=tid%></td>
                </tr>               
                <%if(payMethod.equals("CARD")){%>
                  <tr>
                    <th><span>ī����</th>
                    <td><%=cardName%></td>
                  </tr>
                  <tr>
                    <th><span>�Һΰ���</th>
                    <td><%=cardQuota%></td>
                  </tr>
                <%}else if(payMethod.equals("BANK")){%>
                  <tr>
                    <th><span>����</th>
                    <td><%=bankName%></td>
                  </tr>
                  <tr>
                    <th><span>���ݿ����� Ÿ��</th>
                    <td><%=rcptType%>(0:�������,1:�ҵ����,2:��������)</td>
                  </tr>
                <%}else if(payMethod.equals("CELLPHONE")){%>
                  <tr>
                    <th><span>����� ����</th>
                    <td><%=carrier%></td>
                  </tr>
                  <tr>
                    <th><span>�޴��� ��ȣ</th>
                    <td><%=dstAddr%></td>
                  </tr>
                <%}else if(payMethod.equals("VBANK")){%>
                  <tr>
                    <th><span>�Ա� ����</th>
                    <td><%=vbankBankName%></td>
                  </tr>
                  <tr>
                    <th><span>�Ա� ����</th>
                    <td><%=vbankNum%></td>
                  </tr>
                  <tr>
                    <th><span>�Ա� ����</th>
                    <td><%=vbankExpDate%></td>
                  </tr>
                <%}%>
            </td>
          </table>
        </div>
      </div>
      <p>*�׽�Ʈ ���̵��ΰ�� ���� ���� 11�� 30�п� ��ҵ˴ϴ�.</p>
    </div>
  </div>
</body>
</html>