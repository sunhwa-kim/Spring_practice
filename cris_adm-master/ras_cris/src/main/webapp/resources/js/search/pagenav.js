// 페이지 이동 1,2, ... 하는 HTML 코드를 생성해서 돌려준다.
//	funcName : 실제 페이지 이동을 위한 함수이름 (예: gotoPage)
//	pageNum : 현재 페이지 번호
//	pageSize : 한 페이지당 결과 갯수
//	total : 전체 결과 갯수

function navAnchor( funcName, pageNo, anchorText )
{
    var font_class = "<a class=\"paging-item\" href=\"javascript:{" + funcName + "(" + pageNo + ")}\">" + anchorText + "</a>";    
	return font_class;
}

// 현재 선택된 페이지
function navAnchorSelect( funcName, pageNo, anchorText )
{
    var font_class = "<a class=\"paging-item on\" href=\"javascript:{" + funcName + "(" + pageNo + ")}\">" + anchorText + "</a>";    
	return font_class;
}


// 클래스 있는 버전
function navAnchorByCls( funcName, pageNo, anchorText, title )
{
    var font_class = "<a class=\"list_pa\" href=\"javascript:{" + funcName + "(" + pageNo + ")}\" title=\"" + title + "\" >" + anchorText + "</a>";    
	return font_class;
}

function pageNav( funcName, pageNum, pageSize, total )
{
	if( total < 1 )
		return "";

	var ret = "";
	var PAGEBLOCK=10;
	var totalPages = Math.floor((total-1)/pageSize) + 1;

	var firstPage = Math.floor((pageNum-1)/PAGEBLOCK) * PAGEBLOCK + 1;
	if( firstPage <= 0 ) // ?
		firstPage = 1;

	var lastPage = firstPage-1 + PAGEBLOCK;
	if( lastPage > totalPages )
		lastPage = totalPages;
		
	if( firstPage > PAGEBLOCK )
	{
        //ret += navAnchorByCls(funcName, 1, "<img src='/ncmik/images/ncmik/ptl/search/btn_pre_02.gif' alt='처음으로가기' width='22' height='22'>", "첫 페이지로 이동") + " ";
		//ret += navAnchorByCls(funcName, firstPage-1, "<img src='/ncmik/images/ncmik/ptl/search/btn_pre_01.gif' alt='앞으로가기' width='22' height='22'>", "이전 10페이지로 이동") + " ";
		ret += navAnchorByCls(funcName, 1, "<span class=\"results-paging-previous\">&nbsp;&nbsp;&nbsp;&nbsp;</span>", "첫 페이지로 이동") + " ";
		ret += navAnchorByCls(funcName, firstPage-1, "이전", "이전 10페이지로 이동") + " ";
		
	}

	for( i=firstPage; i<=lastPage; i++ )
	{
		/*if( pageNum == i )
			ret += "<strong class=\"paging_cur_number\">" + i + "</strong>" + " ";
		else
			ret += navAnchor(funcName, i, i) + " ";
		*/
		
		if( pageNum == i )
			ret += navAnchorSelect(funcName, i, i) + " ";
		else
			ret += navAnchor(funcName, i, i) + " ";
		
	}

	if( lastPage < totalPages )
	{
		//ret += navAnchorByCls(funcName, lastPage+1, "<img src='/ncmik/images/ncmik/ptl/search/btn_next_01.gif' alt='뒤로가기' width='22' height='22'>", "다음 10페이지로 이동") + " ";
		//ret += navAnchorByCls(funcName, totalPages, "<img src='/ncmik/images/ncmik/ptl/search/btn_next_02.gif' alt='마지막으로가기' width='22' height='22'>", "마지막 페이지로 이동") + "\n";
		ret += navAnchorByCls(funcName, lastPage+1, "다음", "다음 10페이지로 이동") + " ";
		ret += navAnchorByCls(funcName, totalPages, "<span class=\"results-paging-next\">&nbsp;&nbsp;&nbsp;&nbsp;</span>", "마지막 페이지로 이동") + "\n";
		//ret += navAnchor(funcName, totalPages, totalPages) + "\n";
	}	
	return ret;
}

function pageNavMobile( funcName, pageNum, pageSize, total )
{
	if( total < 1 )
		return "";

	var ret = "";
	var PAGEBLOCK=5;
	var totalPages = Math.floor((total-1)/pageSize) + 1;

	var firstPage = Math.floor((pageNum-1)/PAGEBLOCK) * PAGEBLOCK + 1;
	if( firstPage <= 0 ) // ?
		firstPage = 1;

	var lastPage = firstPage-1 + PAGEBLOCK;
	if( lastPage > totalPages )
		lastPage = totalPages;
		
	if( firstPage > PAGEBLOCK )
	{
        ret += navAnchorByCls(funcName, 1, "<img src='${ctxt}/images/ncmik/ptl/search/btn_pre_02.gif' alt='처음으로가기' width='22' height='22'>", "첫 페이지로 이동") + " ";
		ret += navAnchorByCls(funcName, firstPage-1, "<img src='${ctxt}/images/ncmik/ptl/search/btn_pre_01.gif' alt='앞으로가기' width='22' height='22'>", "이전 10페이지로 이동") + " ";
	}

	for( i=firstPage; i<=lastPage; i++ )
	{
		if( pageNum == i )
			ret += "<strong>" + i + "</strong>" + " ";
		else
			ret += navAnchor(funcName, i, i) + " ";
	}

	if( lastPage < totalPages )
	{
		//ret += navAnchorByCls(funcName, lastPage+1, "<img src='/ncmik/images/ncmik/ptl/search/btn_next_01.gif' alt='뒤로가기' width='22' height='22'>", "다음 10페이지로 이동") + " ";
		//ret += navAnchorByCls(funcName, totalPages, "<img src='/ncmik/images/ncmik/ptl/search/btn_next_02.gif' alt='마지막으로가기' width='22' height='22'>", "마지막 페이지로 이동") + "\n";
		
		ret += navAnchorByCls(funcName, lastPage+1, ">", "다음 10페이지로 이동") + " ";
		ret += navAnchorByCls(funcName, totalPages, ">>", "마지막 페이지로 이동") + "\n";
		
		
	//	ret += navAnchor(funcName, totalPages, totalPages) + "\n";
	}	
	return ret;
}
