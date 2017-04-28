<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.nicepay.module.lite.util.NicePayParamSetter"%>
<%@ page import="java.net.InetAddress"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.Date"%>
<%
/*
*******************************************************
* <������û �Ķ����>
* ������ Form �� ������ ������û �Ķ�����Դϴ�.
* ���������������� �⺻(�ʼ�) �Ķ���͸� ���õǾ� ������, 
* �߰� ������ �ɼ� �Ķ���ʹ� �����޴����� �����ϼ���.
*******************************************************
*/
String merchantKey      = "33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A==";   // ����Ű
String merchantID       = "nictest00m";                      // �������̵�
// String goodsCnt         = "1";                               // ������ǰ����
// String goodsName        = "���̽�����";                      // ������ǰ��
// String price            = "1004";                            // ������ǰ�ݾ�	
// String buyerName        = "���̽�";                          // �����ڸ�
// String buyerTel         = "010-8638-1719";                   // �����ڿ���ó
// String buyerEmail       = "bleach87@naver.com";                 // �����ڸ����ּ�
// String moid             = "mnoid1234567890";                 // ��ǰ�ֹ���ȣ	
// String encodeParameters = "CardNo,CardExpire,CardPwd";       // ��ȣȭ����׸� (����Ұ�)   
    
/*
*******************************************************
* <�ؽ���ȣȭ> (�������� ������)
* MD5 �ؽ���ȣȭ�� �ŷ� �������� �������� ����Դϴ�. 
*******************************************************
*/    
NicePayParamSetter paramSetter = new NicePayParamSetter();	
String ediDate = paramSetter.getyyyyMMddHHmmss();
String md_src = ediDate + merchantID + price + merchantKey;
String hash_String  = paramSetter.encrypt(md_src);
    
/*
******************************************************* 
* <���� IP��>
*******************************************************
*/
InetAddress inet= InetAddress.getLocalHost();	    
%>
<!DOCTYPE html>
<html>
<head>
<title>NICEPAY PAY REQUEST</title>
<meta charset="euc-kr">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/payment/import.css"/>
<script src="https://web.nicepay.co.kr/flex/js/nicepay_tr_ns_utf.js" type="text/javascript"></script>
<script type="text/javascript">
//����â ���� ��û�� ����˴ϴ�. <<'nicepaySubmit()' �̸� ���� �Ұ���>>
function nicepayStart(){
    document.getElementById("vExp").value = getTomorrow();
    goPay(document.payForm);
}

//���� ���� ��û�� ����˴ϴ�. <<'nicepaySubmit()' �̸� ���� �Ұ���>>
function nicepaySubmit(){
    document.payForm.submit();
}

//����â ���� �Լ� <<'nicepayClose()' �̸� ���� �Ұ���>>
function nicepayClose(){
    alert("������ ��� �Ǿ����ϴ�");
}

//��������Աݸ����� ���� (today +1)
function getTomorrow(){
    var today = new Date();

    var yyyy = today.getFullYear().toString();
    var mm = (today.getMonth()+1).toString();
    var dd = (today.getDate()+1).toString();
    if(mm.length < 2){mm = '0' + mm;}
    if(dd.length < 2){dd = '0' + dd;}
    return (yyyy + mm + dd);
}
</script>
</head>
<body>
<form name="payForm" method="post" action="payResult">
    <div class="payfin_area">
      <div class="top">���� ��û ����</div>
      <div class="conwrap">
        <div class="con">
          <div class="tabletypea">
            <table>
              <colgroup><col width="30%" /><col width="*" /></colgroup>
              <tr>
                <th><span>���� ����</span></th>
                <td>
                  <select name="PayMethod">
                    <option value="CARD">�ſ�ī��</option>
                    <option value="BANK">������ü</option>
                    <option value="CELLPHONE">�޴�������</option>
                    <option value="VBANK">�������</option>
                  </select>
                </td>
              </tr>
              <tr>
                <th><span>���� ��ǰ��</span></th>
                <td><input type="text" name="GoodsName" value="<%=goodsName%>"></td>
              </tr>			  
              <tr>
                <th><span>���� ��ǰ����</span></th>
                <td><input type="text" name="GoodsCnt" value="<%=goodsCnt%>"></td>
              </tr>	  
              <tr>
                <th><span>���� ��ǰ�ݾ�</span></th>
                <td><input type="text" name="Amt" value="<%=price%>"></td>
              </tr>	  
              <tr>
                <th><span>�����ڸ�</span></th>
                <td><input type="text" name="BuyerName" value="<%=buyerName%>"></td>
              </tr>	  
              <tr>
                <th><span>������ ����ó</span></th>
                <td><input type="text" name="BuyerTel" value="<%=buyerTel%>"></td>
              </tr>    
              <tr>
                <th><span>��ǰ �ֹ���ȣ</span></th>
                <td><input type="text" name="Moid" value="<%=moid%>"></td>
              </tr>	  
              <tr>
                <th><span>���� ���̵�</span></th>
                <td><input type="text" name="MID" value="<%=merchantID%>"></td>
              </tr>             
              
              <!-- �����̿����� & IP�� -->
              <input type="hidden" name="UserIP" value="<%=request.getRemoteAddr()%>"/>    <!-- ȸ�����IP -->
              <input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>"/>      <!-- ��������IP -->
              
              <!-- ���� ���� �ɼ� �Ķ���� -->
              <input type="hidden" name="VbankExpDate" id="vExp"/>                         <!-- ��������Աݸ����� -->
              <input type="hidden" name="BuyerEmail" value="<%=buyerEmail%>"/>             <!-- ������ �̸��� -->				  
              <input type="hidden" name="GoodsCl" value=""/>                               <!-- ��ǰ���� -->
              
              <!-- �Ϲ�(0)/����ũ��(1) ���� �Ķ���� -->
              <input type="hidden" name="TransType" value="0"/> 
              
              <!-- ���� �Ұ��� -->
              <input type="hidden" name="EncodeParameters" value="<%=encodeParameters%>"/> <!-- ��ȣȭ����׸� -->
              <input type="hidden" name="EdiDate" value="<%=ediDate%>"/>                   <!-- ���� �����Ͻ� -->
              <input type="hidden" name="EncryptData" value="<%=hash_String%>"/>           <!-- �ؽ���	-->
              <input type="hidden" name="TrKey" value=""/>                                 <!-- �ʵ常 �ʿ� -->
              <input type="hidden" name="MerchantKey" value="<%=merchantKey%>"/>           <!-- ���� Ű -->
            </table>
          </div>
        </div>
        <div class="btngroup">
          <a href="#" class="btn_blue" onClick="nicepayStart();">�� û</a>
        </div>
      </div>
    </div>
</form>
</body>
</html>