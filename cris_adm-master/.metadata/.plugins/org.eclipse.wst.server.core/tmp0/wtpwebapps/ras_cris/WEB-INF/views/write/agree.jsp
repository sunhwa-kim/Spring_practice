<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>임상연구정보서비스 등록 동의서</title>
</head>
<body>
<div id="wrapper">
	<div id="container">
			<div id="sideB" class="sideB">
					<div class="step">
						<img src="../images/request_top.gif" alt="임상연구정보공유서비스 등록 동의서" />
						<div id="requestinfo">
							질병관리본부에서 운영하는 &#60;임상연구정보서비스&#62;에 임상연구를 등록하기 위해서는 아래 사항에 동의하여야 합니다.</div>
						<img src="../images/cris_sline686.gif" alt="" />
						<div>
							<textarea title="임상연구정보서비스 등록 동의서 내용" style="width:650px; height:350px; margin:5px 0px 5px 2px; padding:20px 15px 20px 15px;" readonly="readonly">
1. 목 적
본 임상연구정보서비스(Clinical Research information Service: CRIS)는 국내·외 임상연구의 정보 공유를 통하여, 과학적이고 윤리적인 임상연구 수행을 촉진하기 위한 등록시스템입니다.

2. 유의사항
1) 임상연구정보는 정확한 자료와 검증된 보편·타당한 용어를 사용하여 등록합니다.
2) 임상연구는 등록 전에 각 기관연구윤리심의위원회(Institutional Review Board)로부터 승인을 받아야 합니다.
3) 임상연구정보의 갱신은 연구종료 시까지 승인일/갱신일 기준으로 매 6개월 이내에 이루어져야 합니다.
4) 부정확한 정보 또는 이중등록을 방지하기 위하여, 다기관연구인 경우에는 책임 연구자의 소속기관에서 임상연구정보를 등록하여야 합니다.

3. 등록 시 혜택
1) 본 CRIS는 WHO Primary registry에 등록되어 있어, 타국가의 임상 연구등록시스템에 이중 등록할 필요가 없습니다.
2) 등록된 임상연구정보는 관리자의 승인시점부터 웹상에서 실시간으로 공개되며, 국내·외 임상연구자와 공유할 수 있습니다.

4. 권한 및 책임
1) 본 CRIS에 등록된 임상연구정보는 책임연구자의 권한을 부여받고, CRIS 관리자가 승인한 등록자에 의해서만 정보의 등록 및 갱신이 가능합니다.
2) 등록된 정보에 대한 일체의 권한 및 의무와 책임은 각 임상연구정보를 등록한 책임연구자에게 있습니다.

CRIS는 등록된 임상연구정보의 정확성 및 이를 등록함으로써 발생할 수 있는 직접 또는 간접적 손실에 대하여 책임을 지지 않습니다.

본 연구자는 동의서 설명을 이해하였으며, CRIS의 요구사항 및 임상연구정보제공에 대하여 동의합니다.
							</textarea>
						</div>
						<div style="margin:5px 0px 15px 0px;">※ 기타 문의사항은 CRIS 관리자(043-249-3021)에게 연락하여 주시기 바랍니다.</div>
						<div class="tcenter"><a href="${ctxt}/write/cris_write.do"><img src="../images/btn_agree.gif" alt="동의합니다" /></a><a href="javascript:alert('동의하셔야 등록이 가능합니다');"><img src="../images/btn_disagree.gif" alt="동의하지 않습니다" /></a></div>
			</div>
		</div>
  </div><!-- //container -->
</div><!-- wrapper -->

<hr />  
</body>
</html>
