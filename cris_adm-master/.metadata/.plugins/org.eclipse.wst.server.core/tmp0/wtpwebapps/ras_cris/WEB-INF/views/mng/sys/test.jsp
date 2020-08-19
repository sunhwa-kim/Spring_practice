<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	

	function checkFileType(filePath) {
		var fileFormat = filePath.split(".");
		if (fileFormat.indexOf("xls") > -1) {
			return true;
		} else if (fileFormat.indexOf("xlsx") > -1) {
			return true;
		} else {
			return false;
		}
	}

	function check() {
		var file = $("#upload").val();
		if (file == "" || file == null) {
			alert("파일을 선택");
			return false;
		} else if (!checkFileType(file)) {
			alert("엑셀 파일만 업로드");
			return false;
		}
		var fileFormat = file.split(".");
		var fileType = fileFormat[1];
		if (confirm("업로드 하시겠습니까?")) {
			$("form").submit();
		}
	}
</script>

<div class="page-content-wrapper">
	<!-- BEGIN CONTENT BODY -->
	<div class="page-content">
		<div class="page-head">
			<!-- BEGIN PAGE TITLE -->
			<div class="page-title">
				<h1>
					<span id="title"></span><small id="titleSmall"></small>
				</h1>
			</div>
			<!-- END PAGE TITLE -->
		</div>
		<div class="col-lg-10 well">
			<div class="row">
				<form id="excelUpForm" method="post" action="/mng/sys/execlUpload.do?${_csrf.parameterName}=${_csrf.token}" role="form"
					enctype="multipart/form-data">
					<div class="col-sm-12">
						<div class="row" id="regGoodsImgArea">
							<div class="col-sm-4">
								<label>엑셀업로드 </label> <input id="upload"
									name="upload" class="file" type="file" multiple
									data-show-upload="false" data-show-caption="true" />
							</div>
						</div>
					</div>
					<button type="button" id="excelUp" onclick="check()">등록</button>
				</form>
			</div>
		</div>
		<!-- END container -->
	</div>
	<!-- END CONTENT BODY -->
</div>
<!-- END CONTENT -->

