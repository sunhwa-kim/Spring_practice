<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript">
	var id_by_classBefore = "";
	var checkDel = "";
	$(function() {
		$('.check_chlid').click(function() {
			if ($(this).parent().find('input').is(":checked")) {
				$(this).parent().find('input').prop('checked', false);
			} else {
				$(this).parent().find('input').prop('checked', true);
			}
		});

		$('.a_btn')
				.on(
						'click',
						function() {
							var id_by_class = $(this).attr('id');

							if (id_by_classBefore == '') {
								id_by_classBefore = id_by_class;
								$("#" + id_by_class)
										.attr('style',
												'background-color: rgba(0, 57, 100, 1);color:#Fff;');
							} else {
								$("#" + id_by_classBefore).attr('style', '');
							}

							if (id_by_classBefore != id_by_class) {
								$("#" + id_by_class)
										.attr('style',
												'background-color: rgba(0, 57, 100, 1);color:#Fff;');
							}
							id_by_classBefore = id_by_class;
						})

		//소장자료 발행년도  클릭시
		$('.yearClass').click(
				function() {
					$("#searchMove").find("input[name='searchYearList']")
							.remove();
					$(".yearClass input").each(
							function(i) {
								if ($(this).is(":checked")) {
									$("#searchMove").append(
											"<input type='hidden' name='searchYearList' value='"
													+ $(this).val() + "' />");
								}
							});

					$("#searchNlmcMove").val('');
					$("#searchLangMove").val('');
					$("#pageNumMove").val('1');
					$("#pageSizeMove").val('10')

					$("#searchMove").submit();
				});

		//소장자료 주제어  클릭시
		$('.nlmcClass').click(
				function() {
					$("#searchMove").find("input[name='searchNlmcList']")
							.remove();
					$(".nlmcClass input").each(
							function(i) {
								if ($(this).is(":checked")) {
									$("#searchMove").append(
											"<input type='hidden' name='searchNlmcList' value='"
													+ $(this).val() + "' />");
								}
							});

					//$("#searchNlmcMove").val('');
					//$("#searchLangMove").val('');
					$("#pageNumMove").val('1');
					$("#pageSizeMove").val('10')

					$("#searchMove").submit();
				})

		//소장자료 언어  클릭시
		$('.langClass').click(
				function() {
					$("#searchMove").find("input[name='searchLangList']")
							.remove();
					$(".langClass input").each(
							function(i) {
								if ($(this).is(":checked")) {
									$("#searchMove").append(
											"<input type='hidden' name='searchLangList' value='"
													+ $(this).val() + "' />");
								}
							});

					//$("#searchNlmcMove").val('');
					//$("#searchLangMove").val('');
					$("#pageNumMove").val('1');
					$("#pageSizeMove").val('10')

					$("#searchMove").submit();
				})

		viewIsBibFile('volume');
		viewIsBibFile('report');
	});
	var isChk = false;
	//전체선택 / 취소
	function fn_all() {
		$("input[name=chk_mylib]").each(function() {
			if (isChk) {
				$('#all_chk').text("전체선택");
				$(this).prop("checked", false);
			} else {
				$('#all_chk').text("전체취소");
				$(this).prop("checked", true);
			}
		});
		isChk = !isChk;

	}

	/* 소장정보 조회  STR*/
	var dupleChk = "";
	function fn_haveInfo(bibctrlno, rowVal, subTarget) {

		var rowIdx = rowVal;
		var subTarget = subTarget;
		var params = {};

		if (dupleChk == rowIdx) { //열었던것 다시 닫기
			$("div[id^='haveInfo']").children().remove();
			$("#haveInfo" + subTarget + rowIdx).attr('style', '');
			dupleChk = "";
			return;
		}

		$
				.ajax({
					url : '${ctxt}/mlib/readBibacs.do?bibctrlno=' + bibctrlno,
					data : params,
					type : 'GET',
					dataType : 'text',
					async : false,
					cache : false,
					success : function(rtnXml) {
						$(".haveInfovolumeCl").attr("style", "");
						xmlList = $(rtnXml).find('item');

						html = "";

						html += '<table class="basic_table" summary="번호, 등록번호, 청구기호, 배가위치, 도서상태, 반납예정일, 예약 정보를 가지고 있는 소장정보 테이블 입니다.">';
						html += '<caption>소장정보 표</caption>';
						html += '<colgroup>';
						html += '<col width="20%">';
						html += '<col width="20%">';
						html += '<col width="*">';
						html += '<col width="10%">';
						html += '<col width="15%">';
						html += '<col width="10%">';
						html += '</colgroup>';
						html += '<thead>';
						html += '<tr>';
						html += '<th scope="col">등록번호</th>';
						html += '<th scope="col">청구기호</th>';
						html += '<th scope="col">권차사항</th>';
						html += '<th scope="col">자료상태</th>';
						html += '<th scope="col">배가위치</th>';
						html += '<th scope="col">예약</th>';
						html += '</tr>';
						html += '</thead>';
						html += '<tbody id="bodyInfo">';

						if (xmlList.length > 0) {

							xmlList
									.each(function(cnt) {

										var obj = $(this);
										var acsno = obj.find('acsno').text(); //

										var callno = obj.find('callno').text(); //
										var pubyear = obj.find('pubyear')
												.text(); //
										var volumeno = obj.find('volumeno')
												.text(); //
										var mtrlstatus = obj.find('mtrlstatus')
												.text(); //
										var bookcasetype = obj.find(
												'bookcasetype').text(); //
										var reserve = obj.find('reserve')
												.text(); //

										if (subTarget == 'period') {
											if (acsno.substring(0, 2) == 'WS'
													|| acsno.substring(0, 2) == 'ES') {
												html += '<tr>';
												html += '<td style="text-align: center" >'
														+ acsno + '</td>';
												html += '<td style="text-align: left" >'
														+ callno + '</td>';
												html += '<td style="text-align: center" >'
														+ volumeno + '</td>';
												html += '<td style="text-align: center" >'
														+ mtrlstatus + '</td>';
												html += '<td style="text-align: center" >'
														+ bookcasetype
														+ '</td>';
												html += '<td style="text-align: center" >'
														+ reserve + '</td>';
												html += '</tr>';
											}
										} else {
											html += '<tr>';
											html += '<td style="text-align: center" >'
													+ acsno + '</td>';
											html += '<td style="text-align: left" >'
													+ callno + '</td>';
											html += '<td style="text-align: center" >'
													+ volumeno + '</td>';
											html += '<td style="text-align: center" >'
													+ mtrlstatus + '</td>';
											html += '<td style="text-align: center" >'
													+ bookcasetype + '</td>';
											html += '<td style="text-align: center" >'
													+ reserve + '</td>';
											html += '</tr>';
										}

									});

						} else {

							html += '<tr>';
							html += '<td colspan= "6" style="text-align: center" >조회된 내용이 없습니다.</td>';
							html += '</tr>';

						}

						html += '</tbody>';
						html += '</table>';

						dupleChk = rowVal;

						$("div[id^='haveInfo']").children().remove();

						$("#haveInfo" + subTarget + rowIdx).hide();

						$("#haveInfo" + subTarget + rowIdx).html(html);

						$("#haveInfo" + subTarget + rowIdx).attr('style',
								'border:1px solid #B2CCFF;margin-top:25px;');

						checkDel = rowIdx;

						$("#haveInfo" + subTarget + rowIdx).fadeIn(2000);
						dupleChk2 = "";
					},
					error : function() { // Ajax 전송 에러 발생시 실행
						alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.', 'e');
					}
				});
	}
	/* 소장정보 END  */

	/* 상세정보 조회  STR*/
	var dupleChk2 = "";
	function fn_DetailInfo(bibctrlno, rowVal, subTarget) {

		var rowIdx = rowVal;
		var subTarget = subTarget;
		var params = {};
		params.bibctrlno = bibctrlno;
		// 		params.subTarget = subTarget;
		$("#haveInfo" + checkDel).attr('style', '');
		if (dupleChk2 == rowIdx) { //열었던것 다시 닫기
			$("div[id^='haveInfo']").children().remove();
			$("#haveInfo" + subTarget + rowIdx).attr('style', '');
			$(".abtn").attr('style', '');
			dupleChk2 = "";
			return;
		}

		$
				.ajax({
					url : '${ctxt}/mlib/ajaxMlibView03.do',
					data : params,
					type : 'GET',
					dataType : 'xml',
					async : false,
					cache : false,
					success : function(rtnXml) {
						$(".haveInfovolumeCl").attr("style", "");

						xmlList = $(rtnXml).find('item');
						html = "";
						//         	html +='<div  class="content_wrap">';
						//         	html +='<div class="content_box">';
						//         	html +='<div class="content_list">';
						//         	html +='<div id="bibContent">';
						//         	html +='<div id="JOU_bigbox">';
						html += '<div id="bibElement" class="view_dl_box">';

						if (xmlList.length > 0) {

							xmlList
									.each(function(cnt) {

										var obj = $(this);

										var alternativetitle = obj.find(
												'alternativetitle').text(); //대등표제
										var varianttitle = obj.find(
												'varianttitle').text(); //이형표제
										if (obj.find('firstauthor').text() == null
												|| obj.find('firstauthor')
														.text() == "") { // 저자
											if (obj.find('author').text() == null
													|| obj.find('author')
															.text() == "") {
												var author = "";
											} else {
												var author = obj.find('author')
														.text();
											}
										} else {
											var author = obj
													.find('firstauthor').text();
											if (obj.find('author').text() == null
													|| obj.find('author')
															.text() == "") {
												author += "";
											} else {
												author += "&nbsp;;"
														+ obj.find('author')
																.text();
											}
										}
										var edition = obj.find('edition')
												.text(); //판사항
										var placeofpublication = obj.find(
												'placeofpublication').text(); //발행지
										var publisher = obj.find('publisher')
												.text(); //발행처
										var dateissued = obj.find('dateissued')
												.text(); //발행날짜
										var pages = obj.find('pages').text(); //페이지
										var extent = obj.find('extent').text(); //크기
										var illustrativecontent = obj.find(
												'illustrativecontent').text(); //삽화
										var language = obj.find('language')
												.text(); //언어
										var isbn10 = obj.find('isbn10').text(); //표준번호10
										var isbn13 = obj.find('isbn13').text(); //표준번호13
										var keyword = obj.find('keyword')
												.text(); //주제
										var bibctrlno = obj.find('bibctrlno')
												.text(); //키값
										var description = obj.find(
												'description').text(); //키값
										var original = obj.find('original')
												.text();//원서명
										var acronymTtitle = obj.find(
												'acronymTtitle').text();//축약표제
										var abbreviationTtitle = obj.find(
												'abbreviationTtitle').text();//기타표제
										var publicationFrequencyNote = obj
												.find(
														'publicationFrequencyNote')
												.text();//간행빈도
										var continues = obj.find('continues')
												.text();//선행저록
										var continuedBy = obj.find(
												'continuedBy').text();//후행저록

										var subtitle = obj.find('subtitle')
												.text();//부표제
										var seriesTitle = obj.find(
												'seriesTitle').text();//총서표제
										var pissn = obj.find('pissn').text(); //pissn
										var eissn = obj.find('eissn').text(); //eissn
										var grantId = obj.find('grantId')
												.text(); //연구비지원과제번호
										var reportNo = obj.find('reportNo')
												.text(); //보고서 번호
										var meshTopicalDesc = obj.find(
												'meshTopicalDesc').text(); //MeSH 주제어표제 URI
										var wordsubject = obj.find(
												'wordsubject').text(); //주제어
										var linkoutURL = obj.find('linkoutURL')
												.text(); //원문 주소 URL
										var authorno = obj.find('authorno')
												.text(); //저자
										var kdcValue = obj.find('kdcValue')
												.text(); //KDC 값
										var nlmc = obj.find('nlmc').text(); //NLMC값
										var instituteAbbr = obj.find(
												'instituteAbbr').text(); //기관약자
										var startYear = obj.find('startYear')
												.text(); //창간년도
										var doi = obj.find('doi').text(); //doi
										var ncmikid = obj.find('ncmikid')
												.text(); //NCMIKID

										if (subTarget != 'period') {
											if (subtitle.length > 0) {
												html += '<dl><dt>부표제</dt><dd>'
														+ subtitle
														+ '</dd></dl>';
											}
										}

										if (subTarget == 'period') {
											/* if(acronymTtitle.length > 0){
												html += '<dl><dt>축약표제</dt><dd>'+acronymTtitle+'</dd></dl>';
											}
											if(abbreviationTtitle.length > 0){
												html += '<dl><dt>기타표제</dt><dd>'+abbreviationTtitle+'</dd></dl>';
											} */
											if (alternativetitle.length > 0) {
												html += '<dl><dt>대등서명</dt><dd>'
														+ alternativetitle
														+ '</dd></dl>';
											}
											if (abbreviationTtitle.length > 0) {
												html += '<dl><dt>약어명</dt><dd>'
														+ abbreviationTtitle
														+ '</dd></dl>';
											}
										} else {
											if (alternativetitle.length > 0) {
												html += '<dl><dt>대등표제</dt><dd>'
														+ alternativetitle
														+ '</dd></dl>';
											}
											if (varianttitle.length > 0) {
												html += '<dl><dt>이형표제</dt><dd>'
														+ varianttitle
														+ '</dd></dl>';
											}
										}

										if (subTarget == 'period') {
											if (startYear.length > 0) {
												html += '<dl><dt>창간/폐간연도</dt><dd>'
														+ startYear
														+ '</dd></dl>';
											}
										}

										if (subTarget != 'period') {
											if (original.length > 0) {
												html += '<dl><dt>원서명</dt><dd>'
														+ original
														+ '</dd></dl>';
											}
										}

										if (subTarget != 'period') {
											if (author.length > 0) {
												html += '<dl><dt>저자</dt><dd>'
														+ author + '</dd></dl>';
											}
										}

										if (subTarget != 'period') {
											if (edition.length > 0) {
												html += '<dl><dt>판사항</dt><dd>'
														+ edition
														+ '</dd></dl>';
											}
										}

										if (subTarget != 'period') {
											if (placeofpublication.length > 0
													|| publisher.length > 0
													|| dateissued.length > 0) {
												html += '<dl><dt>발행사항</dt><dd>'
														+ placeofpublication
														+ '&nbsp;:' + publisher
														+ ',&nbsp; '
														+ dateissued
														+ '</dd></dl>';
											}
										}

										if (subTarget == 'period') {
											if (publisher.length > 0) {
												html += '<dl><dt>발행처</dt><dd>'
														+ publisher
														+ '</dd></dl>';
											}
										}

										if (pages.length > 0
												|| extent.length > 0
												|| illustrativecontent.length > 0) {
											html += '<dl><dt>형태사항</dt><dd>'
													+ pages + '&nbsp;:'
													+ illustrativecontent + ';'
													+ extent + '</dd></dl>';
										}

										if (subTarget == 'period') {
											if (publicationFrequencyNote.length > 0) {
												html += '<dl><dt>간행빈도</dt><dd>'
														+ publicationFrequencyNote
														+ '</dd></dl>';
											}
										}

										if (language.length > 0) {
											html += '<dl><dt>언어</dt><dd>'
													+ language + '</dd></dl>';
										}

										if (subTarget != 'period') {
											if (seriesTitle.length > 0) {
												html += '<dl><dt>총서사항</dt><dd>'
														+ seriesTitle
														+ '</dd></dl>';
											}
										}

										if (description.length > 0) {
											html += '<dl><dt>주기사항</dt><dd>'
													+ description
													+ '</dd></dl>';
										}

										if (subTarget != 'period') {
											if (isbn10.length > 0
													|| isbn13.length > 0
													|| pissn.length > 0
													|| eissn.length > 0) {

												html += '<dl><dt>표준번호</dt>';
												if (isbn10.length > 0) {
													html += '<dd>' + isbn10
															+ '</dd>';
												}
												if (isbn13.length > 0) {
													html += '<dd>' + isbn13
															+ '</dd>';
												}
												if (pissn.length > 0) {
													html += '<dd>' + pissn
															+ '(print)</dd>';
												}
												if (eissn.length > 0) {
													html += '<dd>'
															+ eissn
															+ '(electronic)</dd>';
												}
												html += '</dl>';
											}
										} else {
											if (pissn.length > 0
													|| eissn.length > 0
													|| doi.length > 0) {

												html += '<dl><dt>표준번호</dt>';
												if (pissn.length > 0) {
													html += '<dd>' + pissn
															+ '(print)</dd>';
												}
												if (eissn.length > 0) {
													html += '<dd>'
															+ eissn
															+ '(electronic)</dd>';
												}
												if (doi.length > 0) {
													html += '<dd>' + doi
															+ '(DOI)</dd>';
												}
												html += '</dl>';
											}
										}

										if (subTarget != 'period') {
											if (grantId.length > 0
													|| reportNo.length > 0) {
												html += '<dl><dt>표준번호</dt><dd>'
														+ grantId + ''
														+ reportNo
														+ '</dd></dl>';
											}
										}

										if (subTarget == 'period') {
											if (continues.length > 0) {
												var continuesSp = continues
														.split(":");
												html += '<dl><dt>선행저록</dt><dd>'
														+ continuesSp[0]
														+ '</dd></dl>';
											}
											if (continuedBy.length > 0) {
												var continuedBySp = continuedBy
														.split(":");
												html += '<dl><dt>후행저록</dt><dd>'
														+ continuedBySp[0]
														+ '</dd></dl>';
											}
										}

										if (subTarget == 'period') {
											if (ncmikid.length > 0
													|| linkoutURL.length > 0) {
												html += '<dl><dt>링크주소</dt>';
												if (ncmikid.length > 0) {
													//왼쪽 0 제거
													var ncmikId = ncmikid
															.replace(/(^0+)/,
																	"");
													html += '<dd>http://library.nih.go.kr/'
															+ ncmikId + '</dd>';
												}

												if (linkoutURL.length > 0) {
													var linkURL = linkoutURL
															.split(",");
													for ( var i in linkURL) {
														html += '<dd>'
																+ linkURL[i]
																+ '</dd>';
													}
												}
												html += '</dl>';
											}
										}

										if (subTarget != 'period') {
											if (meshTopicalDesc.length > 0) {
												html += '<dl><dt>주제어</dt>';
												var mesh = meshTopicalDesc
														.split(";");
												for ( var i in mesh) {
													html += '<dd>' + mesh[i]
															+ '</dd>';
												}
												html += '</dl>';
											}
										} else {
											if (meshTopicalDesc.length > 0) {
												html += '<dl><dt>MeSH</dt>';
												var mesh = meshTopicalDesc
														.split(";");
												for ( var i in mesh) {
													html += '<dd>' + mesh[i]
															+ '</dd>';
												}
												html += '</dl>';
											}
										}

										if (wordsubject.length > 0) {
											html += '<dl><dt>일반주제</dt><dd>'
													+ wordsubject
													+ '</dd></dl>';
										}

										if (subTarget != 'period') {
											if (linkoutURL.length > 0) {
												html += '<dl><dt>원문정보</dt>';
												var linkURL = linkoutURL
														.split(",");
												for ( var i in linkURL) {
													html += '<dd>' + linkURL[i]
															+ '</dd>';
												}
												html += '</dl>';
											}
										}

										if (subTarget == 'volume'
												|| subTarget == 'period') {
											if (authorno.length > 0
													|| kdcValue.length > 0
													|| nlmc.length > 0) {
												html += '<dl><dt>도서기호</dt><dd>'
														+ kdcValue + '' + nlmc
														+ ' ' + authorno
														+ '</dd></dl>';
											}
										} else if (subTarget == 'report') {
											if (instituteAbbr.length > 0
													|| authorno.length > 0) {
												html += '<dl><dt>도서기호</dt><dd>'
														+ instituteAbbr + ' '
														+ authorno
														+ '</dd></dl>';
											}
										} else {
											if (authorno.length > 0) {
												html += '<dl><dt>도서기호</dt><dd>'
														+ authorno
														+ '</dd></dl>';
											}
										}

										/* if(keyword.length > 0){
											html += '<dl><dt>주제</dt><dd>'+keyword+'</dd></dl>';
										} */

										html += '<input type="hidden" name="bibctrlno" id="bibctrlno" value='+bibctrlno+'>';

									});

						}

						// 			html+="</div>";
						// 			html+="</div>";
						// 			html+="</div>";
						// 			html+="</div>";
						//  		html+="</div>";
						html += "</div>";

						dupleChk2 = rowVal;

						$("div[id^='haveInfo']").children().remove();

						$("#haveInfo" + subTarget + rowIdx).hide();

						$("#haveInfo" + subTarget + rowIdx).html(html);

						$("#haveInfo" + subTarget + rowIdx).show();
						dupleChk = "";
					},
					error : function() { // Ajax 전송 에러 발생시 실행
						alert('오류가 발생했습니다.<br /> 관리자에게 문의 바랍니다.', 'e');
					}
				});
	}
	/* 상세정보 END  */

	function go_DetailView(bibctrlno, sub) {
		//var subTarget = "${vo.searchSubTarget}";
		var subTarget = $("#searchSubTargetMove").val();
		var value = sub;
		if (subTarget == "total") {
			if (sub == 'volume') {
				location.href = "${ctxt}/search/mlibView03.do?bibctrlno="
						+ bibctrlno;
			} else if (sub == 'report') {
				location.href = "${ctxt}/search/mlibView04.do?bibctrlno="
						+ bibctrlno;
			} else if (sub == 'notbook') {
				location.href = "${ctxt}/search/mlibView06.do?bibctrlno="
						+ bibctrlno;
			} else if (sub == 'period') {
				location.href = "${ctxt}/search/mlibView05.do?bibctrlno="
						+ bibctrlno;
			}
		} else if (subTarget == "volume") {
			var form = document.volumeForm;
			form.action = "${ctxt}/search/mlibView03.do?bibctrlno=" + bibctrlno;
			form.submit();
		} else if (subTarget == "report") {
			var form = document.reportForm;
			form.action = "${ctxt}/search/mlibView04.do?bibctrlno=" + bibctrlno;
			form.submit();
		} else if (subTarget == "notbook") {
			var form = document.notbookForm;
			form.action = "${ctxt}/search/mlibView06.do?bibctrlno=" + bibctrlno;
			form.submit();
		} else if (subTarget == "period") {
			var form = document.periodForm;
			form.action = "${ctxt}/search/mlibView05.do?bibctrlno=" + bibctrlno;
			form.submit();
		}

	}

	/**
	 * 내서재담기 multi
	 */
	function selMultiMyLib(subTarget) {
		var chk_mylib_cnt = 0;
		var mylibChk = "";
		if ("${userVo.emplyrnm}" == "") {
			if (confirm("내서재 담기 기능을 선택하실 경우 로그인 하셔야합니다.\n로그인 화면으로 이동하시겠습니까?")) {
				location.href = "${ctxt}/login/user/login.do?returnURL=/mlib/mlibList.do";
				return;
			} else {
				return;
			}
		}

		$("input[name=chk_mylib]:checked").each(function() {
			mylibChk += $(this).val() + ",";

			if (mylibChk != "") {
				chk_mylib_cnt++;
			}

		});

		var params = {};
		params.key = mylibChk.substring(0, mylibChk.length - 1);
		params.gbn = "mlib";
		params.subTarget = subTarget;

		$.ajax({
			url : "<c:url value='/mylib/lib/multiMylibSave.do'/>",
			data : params,
			type : 'GET',
			dataType : 'json',
			success : function(data) {

				if (confirm("선택하신 총 " + chk_mylib_cnt
						+ "건 중\n내 서재 담기에 성공한 건수: " + data.sucCnt
						+ "건\n이미 내 서재에 등록된 건수(내 서재 담기에 실패한 건수): " + data.dupCnt
						+ "건 \n입니다.\n\n※ 내 서재 화면으로 이동하시겠습니까?")) {
					location.href = "<c:url value='/mylib/lib/listMyLib.do'/>";
					return;
				} else {

					$("input[name=chk_mylib]").prop("checked", false);

					return;
				}
			}
		});
	}

	// function fn_view(bibctrlno){
	// 	var l, t;
	// 	l = (screen.width-1000);
	// 	t = (screen.height-700)/2;

	// 	window.open('${ctxt}/mlib/readBibacs.do?bibctrlno='+bibctrlno,'_pop' , 'width='+1000+',height='+600+',left='+l+',top='+t+',resizable=0,scrollbars=1');
	// }

	var viewIsBibFile = function(category) {
		var obj = null;

		obj = $("input[name=chk_mylib]");

		var bibCtrlNos = [];

		$.each(obj, function(i, o) {
			o = $(o);
			bibCtrlNos.push(o.val());
		});

		if (bibCtrlNos.length) {
			$
					.ajax({
						"url" : "<c:url value='/search/SelectIsBibFile.do'/>",
						"data" : {
							"bibCtrlNos" : bibCtrlNos
						},
						"type" : "post",
						"dataType" : "json",
						"success" : function(args) {
							//console.log(args);

							var data = args.data;
							$
									.each(
											obj,
											function(i, o) {
												o = $(o);
												o.val()
												var fileCount = data[o.val()];
												var bibCtrlNo = o.val();
												//alert(fileCount);
												if (fileCount) {
													var isFile = "";
													if (category == 'volume') {
														isFile = "<a class='a_btn' href='javascript:fileView(\""
																+ bibCtrlNo
																+ "\");'>원문정보</a>";
														o
																.parent()
																.find(
																		"li[name^='volumeBtn']")
																.append(isFile);
													} else if (category == 'report') {
														isFile = "<a class='a_btn' href='javascript:fileView(\""
																+ bibCtrlNo
																+ "\");'>원문정보</a>";
														o
																.parent()
																.find(
																		"li[name^='reportBtn']")
																.append(isFile);
													} else if (category == 'period') {
														//isFile= $("<a class='a_btn' href='javascript:fileView(\''${periodList.bibctrlno}'\');'>원문정보</a>");
													} else if (category == 'notbook') {
														//isFile= $("<a class='a_btn' href='javascript:fileView(\''${notbookList.bibctrlno}'\');'>원문정보</a>");
													}

												}
											});
						}
					});
		}
	};

	//원문정보
	function fileView(bibCtrlNo) {

		var contextName = "ncmik";
		var atchFileId = "";
		var pageTitle = "";

		$.ajax({
			url : '${ctxt}/cmm/fms/selectTFFileSch.do',
			data : {
				"bibCtrlNo" : bibCtrlNo
			},
			type : 'POST',
			cache : false,
			success : function(rtnXml) {
				var rXmlList = $(rtnXml).find('item');
				if (rXmlList.length > 0) {
					var numId = "";
					rXmlList.each(function(cnt) {
						var obj = $(this);
						var atchFileId = obj.find('atch_file_id').text(); // code
						if (cnt == 0) {
							numId = atchFileId;
						}
					});
					if (numId != "") {
						popAttfileViewIn(numId, contextName, pageTitle);
					}
				} else {
					alert("원문정보가 존재 하지 않습니다.");
				}
			}
		});
	}
</script>
<style>
#bibElement {
	width: 100%;
	display: inline-block;
	border: 1px solid #B2CCFF;
	border-collapse: collapse;
	margin: 0 0 20px 0;
	font-size: 12px;
	color: #7f7f7f;
	font-weight: 400;
	overflow: visible;
	border-collapse: collapse;
	border-spacing: 0;
	float: left;
	padding: 15px 0px;
}

#bibElement>dl:first-child {
	border-top: 1px solid #CCDDED;
}

#bibElement dl {
	width: 94%;
	margin-left: 3%;
	margin-right: 2%;
	min-height: 26px;
	line-height: 26px;
	background: #EBEEF0;
}

#bibElement dd {
	width: 67%;
	min-height: 26px;
	margin-left: 0;
	padding-left: 3%;
	float: right;
	background: #fff;
}

#bibElement dt {
	font-weight: 400;
	background: /*rgba(51,122,183,0.06)*/ #EBEEF0;
	width: 23%;
	text-align: left;
	float: left;
	height: 20px;
	min-height: 20px;
	display: table-header-group;
	padding-left: 3%;
}

.center_text_01 {
	position: relative;
}

.basic_table {
	width: 96%;
	margin-left: 2%;
	margin-right: 2%;
	border: 0px solid black;
	border-collapse: collapse;
	padding-left: 10px;
	position: relative;
	font-size: 14px;
	color: #7f7f7f;
	margin-bottom: 2%;
	margin-top: 2%;
}

.basic_table th {
	padding: 0px;
	background: rgba(51, 122, 183, 0.1);
	text-align: center;
	color: #6B6B6B;
	font-weight: 400;
	font-size: 12px;
}

.basic_table td {
	padding: 0px;
	font-weight: 400;
	font-size: 12px;
}

.basic_table>thead th, .basic_table td {
	padding: 4px 0;
}

.selectbox_wrap {
	height: 38px;
}
.selectbox_wrap a i{
	margin-right:3px;
}
#selectbox1{
	width:60px;
	background-position:40px center;
}
#selectbox2 {
    width: 75px;
    background-position:55px center;
}
#all_chk{
	width:90px;
}
#searchCondition{
	width:97px;
}
#btnSearch, #searchCondition{
	margin:0;
}
#library1 {
	margin-top: 5px;
}

#search-group.sub {
	margin-top: 66px;
	float:none;
	text-align:center;
	margin-bottom: 25px;
}
#volumeQuery, #reportQuery, #notbookQuery, #periodQuery{
	width: 325px;
}
.sub_center_cont_text {
	margin-bottom: 7px;
}

.category_select {
	z-index: 1;
}
.sub_center_cont_text02{
	font-family:"Noto Sans Korean", sans-serif;
}

@media all and (max-width:640px) {
	.list_title.mliblist {
		top: 28px;
		display: block;
		margin: 0 auto;
		transition: all 0.3s;
		-webkit-transition: all 0.3s;
	}
	.content_box>.content_list{
		padding:40px 20px;
	}
}

@media all and (max-width: 600px) {
	.selectbox_wrap {
		width: 334px;
		transform: translate(0,0); 
		-webkit-transform: translate(0,0); 
		left:auto;
		margin:0 auto;
		text-align:center;
		position:relative;
	}
	#search-group {
		right: 0;
		left: 50%;
		width: 100%;
		transform: translate(-50%, 0);
		-o-transform: translate(-50%, 0);
		-ms-transform: translate(-50%, 0);
		-moz-transform: translate(-50%, 0);
		-webkit-transform: translate(-50%, 0);
		text-align: center;
		transition: all 0.3s;
		-webkit-transition: all 0.3s;
	}
	#selectbox1 {
		margin-left: 0;
	}
	.under_bar2 {
		margin-top: 10px;
		margin-bottom: 25px;
	}
	.content_box>.content_list>.sub_book_wrap>.list_title {
		display: inline;
	}
	#searchCondition {
	    width: 69px;
	}
}
@media all and (max-width:530px) {
	#volumeQuery, #reportQuery, #notbookQuery, #periodQuery{
		width:250px;
	}
}
@media all and (max-width:502px) {
	.content_box>.content_list{
		padding:20px;
	}
	.center_text_01 {
		display: block;
		width: 100%;
		text-align: center;
		transition: all 0.3s;
		-webkit-transition: all 0.3s;
		font-size: 18px;
		margin-top: 10px;
	}
	.under_bar {
		display: none;
	}
	.sub_center_text0{
		top:-30px;
	}
	.sub_center_text>.sub_center_nav{
		line-height:55px;
	}
	#search-group.sub{
		margin-top:70px;
		margin-bottom:20px;
	}
	.center_text_01{
		line-height: 55px;
    	margin-top: 0;
	}
}

@media all and (max-width:494px) {
	.sub_book_wrap {
		margin-top: 0px;
	}
	.content_box>.content_list>.sub_book_wrap>.list_title.mliblist {
		display: none;
	}
	#searchCondition{
		width:auto;
	}
}
@media all and (max-width:450px){
	#volumeQuery, #reportQuery, #notbookQuery, #periodQuery {
	    width: 200px;
	}	
}

@media all and (max-width:405px){
	#volumeQuery, #reportQuery, #notbookQuery, #periodQuery {
	    width: 150px;
	}
}
@media all and (max-width:380px){
	.selectbox_wrap {
	    width: 290px;
    }
	#selectbox1. #selectbox2, #all_chk, .bibliography{
		padding:0 5px;
	}
	#selectbox1 {
	    width: 50px;
	    background-position: 35px center;
	}
	#selectbox2 {
	    width: 65px;
	    background-position: 50px center;
	}
	#all_chk, .center_text_02.bibliography {
	    width: auto;
	    padding-left:5px;
	}
}		

</style>
<c:set var="bookTotalSize"
	value="${data.volume_totalSize + data.notbook_totalSize + data.report_totalSize + data.period_totalSize}" />
<c:if test="${vo.searchSubTarget eq 'total'}">
	<div class="sub_center_text">
		<div class="sub_center_nav">
			<span><img src="${ctxt}/resources/images/sub/home_icon.png"></span>
			<span> > </span> <span>통합검색</span> <span> > </span> <span
				class="active">소장자료</span>
		</div>
		<span class="center_text_01">소장자료<span class="category_select">▼</span>
		</span>

	</div>
	<div class="under_bar"></div>
</c:if>
<!-- 도서 목록 -->
<div class="content_wrap">
	<div class="content_box">
		<div class="content_list">
			<!--단행본-->
			<c:if test="${vo.searchSubTarget eq 'total'}">
				<div class="sub_book_wrap" style="width: 100%">
			</c:if>
			<c:if test="${vo.searchSubTarget ne 'total'}">
				<div class="sub_book_wrap">
			</c:if>

			<c:if test="${vo.searchSubTarget eq 'volume' }">
				<div class="sub_center_text0">
					<div class="sub_center_text">
						<div class="sub_center_nav">
							<span><img
								src="${ctxt}/resources/images/sub/home_icon.png"></span> <span>
								> </span> <span>통합검색</span> <span> > </span> <span>소장자료</span> <span>
								> </span> <span class="active">단행본</span>
						</div>
						<span class="center_text_01">단행본<span>(${data.volume_totalSize}건)</span><span
							class="category_select icon1">▼</span></span>

					</div>
					<div class="under_bar media_bar relative"></div>
				</div>
					
				<form id="volumeForm" name="volumeForm"
					action="${ctxt}/search/search.do" method="post" style="text-align:center;">
					<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
					<input type="hidden" name="searchSubTarget" value="volume" /> <input
						type="hidden" name="pageSize" value="10" />
					<!-- <div class="search_wrap"> -->
					<div id="search-group" class="sub">
						<div class="search-input">
							<label for="searchCombo"></label> <select id="searchCondition"
								name="searchCondition" title="분류">
								<option value="total">전체</option>
								<option value="title">제목</option>
							</select> <label for="searchBox"></label> <input type="text"
								id="volumeQuery" name="searchQuery"
								onkeypress="javascript:if(event.keyCode == 13) { volumeGoSearch(); return false;}"
								placeholder="검색어를 입력해주세요." /> <input type="button"
								id="btnSearch" value="검색" onclick="volumeGoSearch();" />
						</div>
					</div>
					<!-- </div> -->
				</form>
				<!-- <div class="under_bar media_bar relative"></div> -->
				
				<%-- <div class="list_title mliblist"><p style="border:1px solid #f0f;">단행본<span>(${data.volume_totalSize}건)</span></p></div> --%>
			</c:if>

			<c:if test="${vo.searchSubTarget eq 'total'}">
				<div class="list_title" style="margin-top: 0;">
					<p>
						단행본<span>(${data.volume_totalSize}건)</span>
					</p>
				</div>
			</c:if>




			<c:if
				test="${vo.searchSubTarget eq 'total' || vo.searchSubTarget eq 'volume' }">
				
				<div class="under_bar2" style="margin-bottom:5px;"></div>
				<div class="selectbox_wrap search_box">
					<select id="selectbox1" name="pageSize" class="sub_select"
						onchange="moveSize(this.value);">
						<span class="sub_arr"></span>
						<option value="10"
							<c:if test="${vo.pageSize == 10}">selected="selected"</c:if>>10</option>
						<option value="20"
							<c:if test="${vo.pageSize == 20}">selected="selected"</c:if>>20</option>
						<option value="30"
							<c:if test="${vo.pageSize == 30}">selected="selected"</c:if>>30</option>
						<option value="50"
							<c:if test="${vo.pageSize == 50}">selected="selected"</c:if>>50</option>
					</select> 
					<select id=selectbox2 name="searchSort" class="sub_select"
						onchange="moveSort(this.value);">
						<span class="sub_arr"></span>
						<option value="recent"
							<c:if test="${vo.searchSort eq 'recent'}">selected="selected"</c:if>>최신순</option>
						<option value="weight"
							<c:if test="${vo.searchSort eq 'weight'}">selected="selected"</c:if>>정확도순</option>
						<option value="old"
							<c:if test="${vo.searchSort eq 'old'}">selected="selected"</c:if>>오래된순</option>
					</select> 
					<a href="javascript:fn_all()" id="all_chk" class="center_text_02"><i class="far fa-check-square"></i>전체선택</a>
					<a href="javascript:selMultiMyLib('volume')" class="center_text_02 bibliography"><i
							class="fas fa-book"></i>내서재담기
					</a>
					<!-- <a href="#" class="center_text_02">서지사항내려받기<div id="library2"></div></a> -->
				</div>
				<c:choose>
					<c:when test="${data.volume_totalSize >0}">
						<c:forEach var="volumeList" items="${data.volumeList}"
							varStatus="status">
							<div style="padding-bottom: 7px; position: relative;">
								<input id="option" type="checkbox" name="chk_mylib"
									value="${volumeList.bibctrlno}" style="position: absolute;">
								<label for="option"><span><span></span></span></label>
								<div style="margin-left: 28px;">
									<ul>
										<li class="sub_center_cont_text"><a
											href="javascript:go_DetailView('${volumeList.bibctrlno}','volume')">${volumeList.preftitle}
												<c:choose>
													<c:when test="${volumeList.subtitle eq ''}">
											  				${volumeList.subtitle}
											  			</c:when>
													<c:otherwise>
											  				&nbsp;&nbsp;:&nbsp;&nbsp;${volumeList.subtitle}
											  			</c:otherwise>
												</c:choose>
										</a></li>
										<li class="sub_center_cont_text02"><span class="text02_1">저자:
												${volumeList.author}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span
											class="text02_1">발행처: ${volumeList.publisher}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
											<span class="text02_1">발행연도: ${volumeList.dateissued}</span></li>
										<li class="sub_center_cont_text02"><span class="text02_1">청구기호:
												${volumeList.nlmcvalue}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
											<span class="text02_1">배가위치:
												${volumeList.bookcasetype}</span></li>
										<li class="sub_center_cont_text02"
											name="volumeBtn${status.index}"><a class="a_btn"
											id="volume${status.index}"
											href="javascript:fn_haveInfo('${volumeList.bibctrlno}', '${status.index}','volume')">소장정보</a>
											<a class="a_btn" id="volumeDetail${status.index}"
											href="javascript:fn_DetailInfo('${volumeList.bibctrlno}', '${status.index}','volume')">상세정보</a>
										</li>
									</ul>
									<div id="haveInfovolume${status.index}"
										class="haveInfovolumeCl"></div>
								</div>
							</div>
						</c:forEach>
						<c:if test="${vo.searchSubTarget eq 'total'}">
							<a class="more_btn" href="javascript:goSubTarget('volume')"><span>더보기</span></a>
						</c:if>
					</c:when>
					<c:otherwise>
						<div class="not_found">검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해
							주세요.</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${vo.searchSubTarget eq 'volume'}">
						${data.volume_totalPage}
					</c:if>
			<!-- 단행본 끝 -->

			<!-- 보고서 -->
			<c:if test="${vo.searchSubTarget eq 'report'}">
				<div class="sub_center_text0">
					<div class="sub_center_text">
						<div class="sub_center_nav">
							<span><img
								src="${ctxt}/resources/images/sub/home_icon.png"></span> <span>
								> </span> <span>통합검색</span> <span> > </span> <span>소장자료</span> <span>
								> </span> <span class="active">보고서</span>
						</div>
						<span class="center_text_01">보고서<span>(${data.report_totalSize}건)</span><span
							class="category_select icon2">▼</span>
						</span>

					</div>
					<div class="under_bar media_bar relative"></div>
				</div>
				<form id="reportForm" name="reportForm"
					action="${ctxt}/search/search.do" method="post" style="text-align:center;">
					<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
					<input type="hidden" name="searchSubTarget" value="report" /> <input
						type="hidden" name="pageSize" value="10" />
					<!-- 							 <div class="search_wrap"> -->
					<div id="search-group" class="sub">
						<div class="search-input">
							<label for="searchCombo"></label> <select id="searchCondition"
								name="searchCondition" title="분류">
								<option value="total">전체</option>
								<option value="title">제목</option>
							</select> <label for="searchBox"></label> <input type="text"
								id="reportQuery" name="searchQuery"
								onkeypress="javascript:if(event.keyCode == 13) { reportGoSearch(); return false;}"
								placeholder="검색어를 입력해주세요." /> <input type="button"
								id="btnSearch" value="검색" onclick="reportGoSearch();" />
						</div>
					</div>
					<!-- 							 </div> -->
				</form>
				
				
				<%-- <div class="list_title mliblist">
					<p>
						보고서<span>(${data.report_totalSize}건)</span>
					</p>
				</div> --%>
			</c:if>

			<c:if test="${vo.searchSubTarget eq 'total'}">
				<div class="list_title">
					<p>
						보고서<span>(${data.report_totalSize}건)</span>
					</p>
				</div>
			</c:if>

			<c:if
				test="${vo.searchSubTarget eq 'total' || vo.searchSubTarget eq 'report' }">
				<div class="under_bar2" style="margin-bottom:5px;"></div>
				<div class="selectbox_wrap">
					<select id="selectbox1" name="pageSize" class="sub_select"
						onchange="moveSize(this.value);">
						<span class="sub_arr"></span>
						<option value="10"
							<c:if test="${vo.pageSize == 10}">selected="selected"</c:if>>10</option>
						<option value="20"
							<c:if test="${vo.pageSize == 20}">selected="selected"</c:if>>20</option>
						<option value="30"
							<c:if test="${vo.pageSize == 30}">selected="selected"</c:if>>30</option>
						<option value="50"
							<c:if test="${vo.pageSize == 50}">selected="selected"</c:if>>50</option>
					</select> 
					<select id=selectbox2 name="searchSort" class="sub_select"
						onchange="moveSort(this.value);">
						<span class="sub_arr"></span>
						<option value="recent"
							<c:if test="${vo.searchSort eq 'recent'}">selected="selected"</c:if>>최신순</option>
						<option value="weight"
							<c:if test="${vo.searchSort eq 'weight'}">selected="selected"</c:if>>정확도순</option>
						<option value="old"
							<c:if test="${vo.searchSort eq 'old'}">selected="selected"</c:if>>오래된순</option>
					</select> <a href="javascript:fn_all()" id="all_chk" class="center_text_02"><i class="far fa-check-square"></i>전체선택</a>
					<a href="javascript:selMultiMyLib('report')" class="center_text_02 bibliography"><i
							class="fas fa-book"></i>내서재담기
					</a>
					<!-- <a href="#" class="center_text_02">서지사항내려받기<div id="library2"></div></a> -->
				</div>
				<c:choose>
					<c:when test="${data.report_totalSize >0}">
						<c:forEach var="reportList" items="${data.reportList}"
							varStatus="status">
							<div style="padding-bottom: 7px; position: relative;">
								<input id="option" type="checkbox" name="chk_mylib"
									value="${reportList.bibctrlno}" style="position: absolute;">
								<label for="option"><span><span></span></span></label>
								<div style="margin-left: 28px;">
									<ul>
										<li class="sub_center_cont_text"><a
											href="javascript:go_DetailView('${reportList.bibctrlno}','report')">${reportList.preftitle}
												<c:choose>
													<c:when test="${reportList.alternativetitle eq ''}">
															${reportList.alternativetitle}  
														</c:when>
													<c:otherwise>
															= ${reportList.alternativetitle}
														</c:otherwise>
												</c:choose>
										</a></li>
										<li class="sub_center_cont_text02"><span class="text02_1">저자:
												${reportList.author}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span
											class="text02_1">발행처: ${reportList.publisher}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
											<span class="text02_1">발행연도: ${reportList.dateissued}</span></li>
										<li class="sub_center_cont_text02"><span class="text02_1">청구기호:
												${reportList.nlmcvalue}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
											<span class="text02_1">배가위치:
												${reportList.bookcasetype}</span></li>
										<li class="sub_center_cont_text02"
											name="reportBtn${status.index}"><a class="a_btn"
											id="report${status.index}"
											href="javascript:fn_haveInfo('${reportList.bibctrlno}', '${status.index}','report')">소장정보</a>
											<a class="a_btn" id="reportDetail${status.index}"
											href="javascript:fn_DetailInfo('${reportList.bibctrlno}', '${status.index}','report')">상세정보</a></li>
									</ul>
									<div id="haveInforeport${status.index}"
										class="haveInfovolumeCl"></div>
								</div>
							</div>
						</c:forEach>
						<c:if test="${vo.searchSubTarget eq 'total'}">
							<a class="more_btn" href="javascript:goSubTarget('report')"><span>더보기</span></a>
						</c:if>
					</c:when>
					<c:otherwise>
						<div class="not_found">검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해
							주세요.</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${vo.searchSubTarget eq 'report'}">
					${data.report_totalPage}
				</c:if>
			<!-- 보고서 끝 -->


			<!-- 비도서 -->
			<c:if test="${vo.searchSubTarget eq 'notbook' }">
				<div class="sub_center_text0">
					<div class="sub_center_text">
						<div class="sub_center_nav">
							<span><img
								src="${ctxt}/resources/images/sub/home_icon.png"></span> <span>
								> </span> <span>통합검색</span> <span> > </span> <span>소장자료</span> <span>
								> </span> <span class="active">비도서</span>
						</div>
						<span class="center_text_01">소장자료<span
							class="category_select icon3">▼</span>
						</span>

					</div>
					
				</div>
				<form id="notbookForm" name="notbookForm"
					action="${ctxt}/search/search.do" method="post" style="text-align:center;">
					<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
					<input type="hidden" name="searchSubTarget" value="notbook" /> <input
						type="hidden" name="pageSize" value="10" />
					<!-- <div class="search_wrap"> -->
					<div id="search-group" class="sub">
						<div class="search-input">
							<label for="searchCombo"></label> <select id="searchCondition"
								name="searchCondition" title="분류">
								<option value="total">전체</option>
								<option value="title">제목</option>
							</select> <label for="searchBox"></label> <input type="text"
								id="notbookQuery" name="searchQuery"
								onkeypress="javascript:if(event.keyCode == 13) { notbookGoSearch(); return false;}"
								placeholder="검색어를 입력해주세요." /> <input type="button"
								id="btnSearch" value="검색" onclick="notbookGoSearch();" />
						</div>
					</div>
					<!-- </div> -->
				</form>
				
				
				<div class="list_title mliblist">
					<p>
						비도서<span>(${data.notbook_totalSize}건)</span>
					</p>
				</div>
			</c:if>

			<c:if test="${vo.searchSubTarget eq 'total'}">
				<div class="list_title">
					<p>
						비도서<span>(${data.notbook_totalSize}건)</span>
					</p>
				</div>
			</c:if>

			<c:if
				test="${vo.searchSubTarget eq 'total' || vo.searchSubTarget eq 'notbook' }">
				<%-- <span class="center_text_001">비도서<span>(${data.notbook_totalSize}건)</span></span> --%>
				<div class="under_bar2" style="margin-bottom:5px;"></div>
				<div class="selectbox_wrap">
					<select id="selectbox1" name="pageSize" class="sub_select"
						onchange="moveSize(this.value);">
						<span class="sub_arr"></span>
						<option value="10"
							<c:if test="${vo.pageSize == 10}">selected="selected"</c:if>>10</option>
						<option value="20"
							<c:if test="${vo.pageSize == 20}">selected="selected"</c:if>>20</option>
						<option value="30"
							<c:if test="${vo.pageSize == 30}">selected="selected"</c:if>>30</option>
						<option value="50"
							<c:if test="${vo.pageSize == 50}">selected="selected"</c:if>>50</option>
					</select> 
					<select id=selectbox2 name="searchSort" class="sub_select"
						onchange="moveSort(this.value);">
						<span class="sub_arr"></span>
						<option value="recent"
							<c:if test="${vo.searchSort eq 'recent'}">selected="selected"</c:if>>최신순</option>
						<option value="weight"
							<c:if test="${vo.searchSort eq 'weight'}">selected="selected"</c:if>>정확도순</option>
						<option value="old"
							<c:if test="${vo.searchSort eq 'old'}">selected="selected"</c:if>>오래된순</option>
					</select> <a href="javascript:fn_all()" id="all_chk" class="center_text_02"><i class="far fa-check-square"></i>전체선택</a>
					<a href="javascript:selMultiMyLib('notbook')"
						class="center_text_02 bibliography"><i class="fas fa-book"></i>내서재담기
					</a>
					<!-- <a href="#" class="center_text_02">서지사항내려받기<div id="library2"></div></a> -->
				</div>
				<c:choose>
					<c:when test="${data.notbook_totalSize >0}">
						<c:forEach var="notbookList" items="${data.notbookList}"
							varStatus="status">
							<div style="padding-bottom: 7px; position: relative;">
								<input id="option" type="checkbox" name="chk_mylib"
									value="${notbookList.bibctrlno}" style="position: absolute;">
								<label for="option"><span><span></span></span></label>
								<div style="margin-left: 28px;">
									<ul>
										<li class="sub_center_cont_text"><a
											href="javascript:go_DetailView('${notbookList.bibctrlno}','notbook')">${notbookList.preftitle}
												<c:choose>
													<c:when test="${notbookList.subtitle eq ''}">
														${notbookList.subtitle}
													</c:when>
													<c:otherwise>
														&nbsp;&nbsp;:&nbsp;&nbsp;${notbookList.subtitle}
													</c:otherwise>
												</c:choose>
										</a></li>
										<li class="sub_center_cont_text02"><span class="text02_1">저자:
												${notbookList.author}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <span
											class="text02_1">발행처: ${notbookList.publisher}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
											<span class="text02_1">발행연도: ${notbookList.dateissued}</span></li>
										<li class="sub_center_cont_text02"><span class="text02_1">청구기호:
												${notbookList.nlmcvalue}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
											<span class="text02_1">배가위치:
												${notbookList.bookcasetype}</span></li>
										<li class="sub_center_cont_text02"
											name="notbookBtn${status.index}"><a class="a_btn"
											id="notbook${status.index}"
											href="javascript:fn_haveInfo('${notbookList.bibctrlno}', '${status.index}','notbook')">소장정보</a>
											<a class="a_btn" id="notbookDetail${status.index}"
											href="javascript:fn_DetailInfo('${notbookList.bibctrlno}', '${status.index}','notbook')">상세정보</a>
										<!--  <a class="a_btn" href="#">원문정보</a> --></li>
									</ul>
									<div id="haveInfonotbook${status.index}"
										class="haveInfovolumeCl"></div>
								</div>
							</div>
						</c:forEach>
						<c:if test="${vo.searchSubTarget eq 'total'}">
							<a class="more_btn" href="javascript:goSubTarget('notbook')"><span>더보기</span></a>
						</c:if>
					</c:when>
					<c:otherwise>
						<div class="not_found">검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해
							주세요.</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${vo.searchSubTarget eq 'notbook'}">
					${data.notbook_totalPage}
				</c:if>
			<!-- 비도서 끝 -->

			<!-- 정기간행물 -->
			<c:if test="${vo.searchSubTarget eq 'period' }">
				<div class="sub_center_text0">
					<div class="sub_center_text">
						<div class="sub_center_nav">
							<span><img
								src="${ctxt}/resources/images/sub/home_icon.png"></span> <span>
								> </span> <span>통합검색</span> <span> > </span> <span>소장자료</span> <span>
								> </span> <span class="active">연속간행물</span>
						</div>
						<span class="center_text_01">연속간행물<span>(${data.period_totalSize}건)<span
							class="category_select icon4">▼</span></span>
						</span>

					</div>
					<div class="under_bar"></div>
				</div>
				<form id="periodForm" name="periodForm" style="text-align:center;"
					action="${ctxt}/search/search.do" method="post">
					<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
					<input type="hidden" name="searchSubTarget" value="period" /> <input
						type="hidden" name="pageSize" value="10" />
					<!-- <div class="search_wrap"> -->
					<div id="search-group" class="sub">
						<div class="search-input">
							<label for="searchCombo"></label> <select id="searchCondition"
								name="searchCondition" title="분류">
								<option value="total">전체</option>
								<option value="title">제목</option>
							</select> <label for="searchBox"></label> <input type="text"
								id="periodQuery" name="searchQuery"
								onkeypress="javascript:if(event.keyCode == 13) { periodGoSearch(); return false;}"
								placeholder="검색어를 입력해주세요." /> <input type="button"
								id="btnSearch" value="검색" onclick="periodGoSearch();" />
						</div>
					</div>
					<!-- </div> -->
				</form>
				
				
				<%-- <div class="list_title mliblist">
					<p>
						연속간행물<span>(${data.period_totalSize}건)</span>
					</p>
				</div> --%>
			</c:if>

			<c:if test="${vo.searchSubTarget eq 'total'}">
				<div class="list_title">
					<p>
						연속간행물<span>(${data.period_totalSize}건)</span>
					</p>
				</div>
			</c:if>

			<c:if
				test="${vo.searchSubTarget eq 'total' || vo.searchSubTarget eq 'period' }">
				<div class="under_bar2" style="margin-bottom:5px;"></div>
				<div class="selectbox_wrap">
					<select id="selectbox1" name="pageSize" class="sub_select"
						onchange="moveSize(this.value);">
						<span class="sub_arr"></span>
						<option value="10"
							<c:if test="${vo.pageSize == 10}">selected="selected"</c:if>>10</option>
						<option value="20"
							<c:if test="${vo.pageSize == 20}">selected="selected"</c:if>>20</option>
						<option value="30"
							<c:if test="${vo.pageSize == 30}">selected="selected"</c:if>>30</option>
						<option value="50"
							<c:if test="${vo.pageSize == 50}">selected="selected"</c:if>>50</option>
					</select> 
					<select id=selectbox2 name="searchSort" class="sub_select"
						onchange="moveSort(this.value);">
						<span class="sub_arr"></span>
						<option value="recent"
							<c:if test="${vo.searchSort eq 'recent'}">selected="selected"</c:if>>최신순</option>
						<option value="weight"
							<c:if test="${vo.searchSort eq 'weight'}">selected="selected"</c:if>>정확도순</option>
						<option value="old"
							<c:if test="${vo.searchSort eq 'old'}">selected="selected"</c:if>>오래된순</option>
					</select> <a href="javascript:fn_all()" id="all_chk" class="center_text_02"><i class="far fa-check-square"></i>전체선택</a>
					<a href="javascript:selMultiMyLib('period')" class="center_text_02 bibliography"><i
							class="fas fa-book"></i>내서재담기
					</a>
					<!-- <a href="#" class="center_text_02">서지사항내려받기<div id="library2"></div></a> -->
				</div>
				<c:choose>
					<c:when test="${data.period_totalSize >0}">
						<c:forEach var="periodList" items="${data.periodList}"
							varStatus="status">
							<div style="padding-bottom: 7px; position: relative;">
								<input id="option" type="checkbox" name="chk_mylib"
									value="${periodList.bibctrlno}" style="position: absolute;">
								<label for="option"><span><span></span></span></label>
								<div style="margin-left: 28px;">
									<ul>
										<li class="sub_center_cont_text"><a
											href="javascript:go_DetailView('${periodList.bibctrlno}','period')">${periodList.preftitle}
												<c:choose>
													<c:when test="${periodList.subtitle eq ''}">
															${periodList.subtitle}
														</c:when>
													<c:otherwise>
															&nbsp;&nbsp;:&nbsp;&nbsp;${periodList.subtitle}
														</c:otherwise>
												</c:choose>
										</a></li>
										<li class="sub_center_cont_text02">
											<%-- <span class="text02_1">저자:</span> ${periodList.author}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;  --%>
											<span class="text02_1">발행처: ${periodList.publisher}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
											<%-- <span class="text02_1">발행연도:</span> ${periodList.dateissued} --%>
										</li>
										<li class="sub_center_cont_text02"><span class="text02_1">청구기호:
												${periodList.nlmcvalue}</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
											<span class="text02_1">배가위치:
												${periodList.bookcasetype}</span></li>
										<li class="sub_center_cont_text02"
											name="periodBtn${status.index}"><a class="a_btn"
											id="period${status.index}"
											href="javascript:fn_haveInfo('${periodList.bibctrlno}', '${status.index}','period')">소장정보</a>
											<a class="a_btn" id="periodDetail${status.index}"
											href="javascript:fn_DetailInfo('${periodList.bibctrlno}', '${status.index}','period')">상세정보</a>
											<%-- <a class="a_btn" href="${ctxt}/search/AdvancedSearch?query=${periodList.preftitle}">원문정보</a> --%></li>
									</ul>
									<div id="haveInfoperiod${status.index}"
										class="haveInfovolumeCl"></div>
								</div>
							</div>
						</c:forEach>
						<c:if test="${vo.searchSubTarget eq 'total'}">
							<a class="more_btn" href="javascript:goSubTarget('period')"><span>더보기</span></a>
						</c:if>
					</c:when>
					<c:otherwise>
						<div class="not_found">검색조건에 해당하는 결과가 없습니다. 다른 검색조건을 선택해
							주세요.</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${vo.searchSubTarget eq 'period'}">
						${data.period_totalPage}
					</c:if>
			<%-- <c:if test="${vo.searchSubTarget eq 'total' || vo.searchSubTarget eq 'period' }"> --%>
		</div>
		<!-- 정기간행물 끝 -->
		<%@include file="../layout/includes/subRightMenu.jsp"%>
	</div>
	<!-- 도서 목록 끝 -->
</div>
</div>


<form id="searchMove" name="searchMove"
	action="${ctxt}/search/search.do" method="post">
	<input type="hidden" id="searchQueryMove" name="searchQuery"
		value="${vo.searchQuery}" /> <input type="hidden" id="pageNumMove"
		name="pageNum" value="${vo.pageNum}" /> <input type="hidden"
		id="pageSizeMove" name="pageSize" value="${vo.pageSize}" /> <input
		type="hidden" id="searchSortMove" name="searchSort"
		value="${vo.searchSort}" /> <input type="hidden"
		id="searchTargetMove" name="searchTarget" value="${vo.searchTarget}" />
	<input type="hidden" id="searchSubTargetMove" name="searchSubTarget"
		value="${vo.searchSubTarget}" /> <input type="hidden"
		id="startDateMove" name="startDate" value="${vo.startDate}" /> <input
		type="hidden" id="endDateMove" name="endDate" value="${vo.endDate}" />
	<input type="hidden" id="searchYearMove" name="searchYear"
		value="${vo.searchYear}" /> <input type="hidden" id="searchNlmcMove"
		name="searchNlmc" value="${vo.searchNlmc}" /> <input type="hidden"
		id="searchLangMove" name="searchLang" value="${vo.searchLang}" />
	<c:if test="${not empty vo.searchNlmcList}">
		<c:forEach var="searchNlmcList" items="${vo.searchNlmcList}"
			varStatus="var">
			<input type="hidden" name="searchNlmcList" value="${searchNlmcList}" />
		</c:forEach>
	</c:if>
	<c:if test="${not empty vo.searchLangList}">
		<c:forEach var="searchLangList" items="${vo.searchLangList}"
			varStatus="var">
			<input type="hidden" name="searchLangList" value="${searchLangList}" />
		</c:forEach>
	</c:if>
	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
</form>
