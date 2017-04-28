<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.nicepay.module.lite.NicePayWebConnector"%>
<%@ page import="kr.co.nicepay.module.lite.util.NicePayUtils"%>
<% request.setCharacterEncoding("euc-kr"); %>
<%
/*
*******************************************************
* <��� ��� ����>
* ����� ��� �ɼ��� ����� ȯ�濡 �µ��� �����ϼ���.
* �α� ���丮�� �� �����ϼ���.
*******************************************************
*/
NicePayWebConnector connector = new NicePayWebConnector();
String requestMid = request.getParameter("MID");
connector.setRequestData(request);

// connector.setNicePayHome("C:/workspace/server/tomcat_8.0/webapps/ROOT/NICEPAY_Lite_JSP/WEB-INF"); // �α� ���丮 ����
connector.setNicePayHome(request.getSession().getServletContext().getRealPath("/WEB-INF/")); // �α� ���丮 ����
connector.addRequestData("MID", requestMid);                        //���� ID
connector.addRequestData("CancelIP", request.getRemoteAddr());      //��� IP
connector.addRequestData("actionType", "CL0");                      // ���񽺸�� ����(���� ���� : PY0 , ��� ���� : CL0)
connector.requestAction();

/*
*******************************************************
* <��� ��� �ʵ�>
*******************************************************
*/
String resultCode = connector.getResultData("ResultCode");          // ����ڵ� (��Ҽ���: 2001, ���������: 2002)
String resultMsg  = connector.getResultData("ResultMsg");           // ����޽���
String cancelAmt  = connector.getResultData("CancelAmt");           // ��ұݾ�
String cancelDate = connector.getResultData("CancelDate");          // �����
String cancelTime = connector.getResultData("CancelTime");          // ��ҽð�
String cancelNum  = connector.getResultData("CancelNum");           // ��ҹ�ȣ
String payMethod  = connector.getResultData("PayMethod");           // ��� ��������
String mid        = connector.getResultData("MID");                 // ���� ID
String tid        = connector.getResultData("TID");                 // TID
String errorCD    = connector.getResultData("ErrorCD");             // �� �����ڵ�
String errorMsg   = connector.getResultData("ErrorMsg");            // �� �����޽���
String authDate   = connector.getResultData("AuthDate");            // �ŷ��ð�

%>
<!DOCTYPE html>
<html>
<head>
<title>NICEPAY CANCEL RESULT</title>
<meta charset="euc-kr">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/payment/import.css"/>
</head>
<body>
  <div class="payfin_area">
    <div class="top">��� ��� ����</div>
    <div class="conwrap">
      <div class="con">
        <div class="tabletypea">
          <table>
            <tr>
              <th><span>�ŷ� ���̵�</th>
              <td><%=tid%></td>
            </tr>
            <tr>
              <th><span>���� ����</th>
              <td><%=payMethod%></td>
            </tr>         
            <tr>
              <th><span>��� ����</th>
              <td>[<%=resultCode%>]<%=resultMsg%></td>
            </tr>
            <tr>
              <th><span>��� �ݾ�</th>
              <td><%=cancelAmt%></td>
            </tr>
            <tr>
              <th><span>�����</th>
              <td><%=cancelDate%></td>
            </tr>
            <tr>
              <th><span>��ҽð�</th>
              <td><%=cancelTime%></td>
            </tr>
          </table>
        </div>
      </div>
      <p>* ��Ұ� ������ ��쿡�� �ٽ� ���λ��·� ���� �� �� �����ϴ�.</p>
    </div>
  </div>
</body>
</html>