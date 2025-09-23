<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/include/jsp/globals.jsp"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>EM-NEO 골프</title>
        <meta name="description" content="EM-NEO 골프" />
        <meta name="keywords" content="EM-NEO 골프" />
        <meta property="og:type" content="website" />
        <meta property="og:image" content="./img/og.png" />
        <meta property="og:title" content="EM-NEO 골프" />
        <meta property="og:description" content="EM-NEO 골프" />
        <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
        <link rel="stylesheet" href="/resources/css/common.css" />
        <link rel="stylesheet" href="/resources/css/style.css" />
        <script src="/resources/js/jquery.3.1.1.js"></script>
    </head>
    <body>
        <div class="wrap">
            <!-- header -->
            <header>
                <h2>
                    <img
                        src="/resources/img/assets/ico_left_arrow.svg"
                        alt="왼쪽 화살표 아이콘"
                        onclick="window.history.back()"
                    />
                    <p>이용내역</p>
                </h2>
                <div class="right">
                    <a href="/app/myPage.do">
                        <img
                            src="/resources/img/assets/ico_setting_white.svg"
                            alt="설정아이콘"
                        />
                    </a>
                </div>
            </header>
            <!-- navigation bar -->
            <nav class="navigation-bar">
                <ul class="navigation-bar__list">
                    <li>
                        <a href="bookingManagement.do">
                            <span>
                                <img
                                    src="/resources/img/assets/ico_main_booking_check_2.svg"
                                    alt="예약확인 메뉴 아이콘"
                                />
                            </span>
                            예약확인
                        </a>
                    </li>
                    <li>
                        <a href="purchase.do" class="click">
                            <span>
                                <img
                                    src="/resources/img/assets/ico_main_purchase_2.svg"
                                    alt="구매내역 메뉴 아이콘"
                                />
                            </span>
                            구매내역
                        </a>
                    </li>
                    <li>
                        <a href="main.do">
                            <span>
                                <img
                                    src="/resources/img/assets/ico_home_2.svg"
                                    alt="메인 아이콘"
                                />
                            </span>
                            메인
                        </a>
                    </li>
                    <li>
                        <a href="use.do">
                            <span>
                                <img
                                    src="/resources/img/assets/ico_main_use_2.svg"
                                    alt="이용내역 메뉴 아이콘"
                                />
                            </span>
                            이용내역
                        </a>
                    </li>
                    <li>
                        <a
                            href="javascript:serviceAlert('서비스 준비 중입니다.')"
                        >
                            <!-- <a href="product.do"> -->
                            <span>
                                <img
                                    src="/resources/img/assets/ico_main_product_2.svg"
                                    alt="상품구매 메뉴 아이콘"
                                />
                            </span>
                            상품구매
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- quick menu -->
            <!-- <a href="./booking.html" class="quick_menu">타석<br />예약</a> -->

            <div class="container">
				<!-- ** use-search 클레스 추가 ** -->
                <div class="search-box search-date use-search">
                    <div class="select-product">
                        <label>이용중인 상품</label>
                        <select
                            class="form-select"
                            aria-label="Default select example"
                            id="product-select"
                        >
                            <c:choose>
                                <c:when test="${not empty salesList}">
                                    <c:forEach var="sale" items="${salesList}">
                                        <option value="${sale.SalesIndex}">
                                            ${sale.MembershipName}
                                        </option>
                                    </c:forEach>
                                    <option value="all">전체</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="">
                                        이용중인 상품이 없습니다.
                                    </option>
                                    <option value="all">전체</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </div>

					<!-- 추가 -->
                    <div class="select-date">
                        <label>기간</label>
                        <div>
                            <label>
                                <input type="date" name="startDt" />
                            </label>
                            <label>
                                <input type="date" name="endDt" />
                            </label>
                        </div>
                    </div>
                </div>

                <div class="list" id="bookingList"></div>
            </div>
            <!-- 안내 모달 -->
            <div id="infoModal" class="custom-modal" style="display: none">
                <div class="custom-modal-content">
                    <div class="custom-modal-header">
                        <h5 class="custom-modal-title">안내</h5>
                        <button
                            class="custom-close-btn"
                            onclick="closeModal('infoModal')"
                        ></button>
                    </div>
                    <div
                        class="custom-modal-body"
                        id="infoModalMessage"
                        style="text-align: center; font-size: 1.6rem"
                    ></div>
                    <div
                        class="custom-modal-footer"
                        style="text-align: center; margin-top: 2.5rem"
                    >
                        <button
                            id="infoModalOk"
                            class="signup__cont__btn-box_2"
                        >
                            확인
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script src="/resources/js/common.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var salesIndex = document.getElementById('product-select');

                function formatDate(date) {
                    var yyyy = date.getFullYear();
                    var mm = String(date.getMonth() + 1).padStart(2, '0'); // 월 (0부터 시작하므로 +1)
                    var dd = String(date.getDate()).padStart(2, '0'); // 일
                    return yyyy + '-' + mm + '-' + dd;
                }

                var today = new Date();
                var threeMonthsAgo = new Date();
                threeMonthsAgo.setMonth(today.getMonth() - 1); // 1개월 전

                // 월이 음수가 되면 연도를 1년 줄이고, 월을 조정
                if (threeMonthsAgo.getMonth() > today.getMonth()) {
                    threeMonthsAgo.setFullYear(today.getFullYear() - 1);
                }

                document.getElementById('startDt').value =
                    formatDate(threeMonthsAgo);
                document.getElementById('endDt').value = formatDate(today);

                var startDtInput = document.querySelector(
                    "input[name='startDt']"
                );
                var endDtInput = document.querySelector("input[name='endDt']");

                onStartDtChange();

                salesIndex.addEventListener('change', onStartDtChange);
                startDtInput.addEventListener('change', onStartDtChange);
                endDtInput.addEventListener('change', onStartDtChange);
            });

            function onStartDtChange() {
                var startDtInput = document.querySelector(
                    "input[name='startDt']"
                );
                var endDtInput = document.querySelector("input[name='endDt']");
                var salesIndex =
                    document.getElementById('product-select').value; // 선택되어있는 상품코드
                var data = {
                    startDt: startDtInput.value,
                    endDt: endDtInput.value,
                    salesIndex: salesIndex,
                };

                var URL = '/app/useDateSearch.do';
                $.ajax({
                    url: URL,
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(data),
                    success: function (response) {
                        var bookingList = response;
                        var listContainer = $('#bookingList');
                        listContainer.empty();

                        if (bookingList.length === 0) {
                            listContainer.append(
                                '<li>조회된 결과가 없습니다.</li>'
                            );
                            return;
                        }

                        var prevSalesIndex = null;
                        var rowNum = 1;
                        var groupDiv = null;

                        bookingList.forEach(function (list, index) {
                            var today = new Date();
                            today.setHours(0, 0, 0, 0); // 오늘 기준

                            // ✅ 상태 판단
                            var status = '';
                            if (list.isRefundYn === 'Y') {
                                status = '환불';
                            } else if (list.isExpiredYn === 'Y') {
                                status = '기간만료';
                            } else if (list.isUsedUpYn === 'Y') {
                                status = '사용완료';
                            } else {
                                status = list.ValidDate;
                            }

                            // ✅ SalesIndex가 바뀌면 새로운 타이틀 블록 추가
                            if (list.SalesIndex !== prevSalesIndex) {
                                groupDiv = $('<div class="group"></div>');
                                var headerItem =
                                    '<p>' +
                                    list.MembershipName +
                                    '<span>' +
                                    status +
                                    '</span></p>';
                                groupDiv.append(headerItem);
                                listContainer.append(groupDiv);
                                prevSalesIndex = list.SalesIndex;
                                rowNum = 1;
                            }

                            var bookingStatusText = '';
                            if (list.bookingStatus === '예약취소') {
                                bookingStatusText =
                                    ' <span style="color:red; font-size:1.2rem; margin-left:0.6rem;">취소</span>';
                            } else if (list.bookingStatus === '예약중') {
                                bookingStatusText =
                                    ' <span style="color:green; font-size:1.2rem; margin-left:0.6rem;">예약중</span>';
                            } else if (list.bookingStatus === '사용완료') {
                                bookingStatusText =
                                    ' <span style="color:blue; font-size:1.2rem; margin-left:0.6rem;">사용완료</span>';
                            } else if (list.bookingStatus === '이용중') {
                                bookingStatusText =
                                    ' <span style="color:blue; font-size:1.2rem; margin-left:0.6rem;">이용중</span>';
                            }

                            // ✅ 예약 시간 표시: StartTimestamp 없으면 BookingCheckInDatetime 사용
                            var startTime =
                                list.StartTimestamp || list.BookingCheckInTime;
                            var endTime =
                                list.CheckOutTimestamp ||
                                list.BookingCheckoutDatetime;

                            var timeParts = formatDateTime(startTime, endTime);
                            var bayName = list.BayName || '0';
                            var bayNameOnlyNumber = bayName.match(/\d+/)
                                ? bayName.match(/\d+/)[0]
                                : bayName;

                            var bayDisplay =
                                bayNameOnlyNumber !== '0' &&
                                bayNameOnlyNumber !== ''
                                    ? '<span style="font-size:1.2rem; font-weight:bold; margin-left:0.5rem;">' +
                                      bayNameOnlyNumber +
                                      '번</span>' +
                                      '<span style="color:green; font-size:1.2rem; margin-left:1.2rem;">' +
                                      bookingStatusText +
                                      '</span>'
                                    : '<span style="font-size:1.3rem; font-weight:bold; margin-left:0.6rem;"> </span>' +
                                      '<span style="color:#1E90FF; font-size:1.2rem; margin-left:1.8rem;"> 실내이용</span>';

                            var listItem =
                                '<div class="list__use">' +
                                '<div>' +
                                '<p><span style="width: 1.5rem;">' +
                                rowNum +
                                '.</span> <span style="width: 8.5rem;">' +
                                timeParts.dateStr +
                                '</span>' +
                                '<span style="width: 3.5rem;">' +
                                timeParts.startTimeStr +
                                '</span>' +
                                ' ~  <span style="width: 3.5rem;">' +
                                timeParts.endTimeStr +
                                '</span>' +
                                bayDisplay +
                                '</p>' +
                                '</div>' +
                                '</div>';
                            rowNum++;
                            groupDiv.append(listItem);
                        });
                    },
                });
            }

            // ✅ 시간 구간을 나눠서 반환하도록 변경
            function formatDateTime(startTimestamp, checkOutTimestamp) {
                var start = new Date(Number(startTimestamp));
                if (isNaN(start.getTime())) {
                    return {
                        dateStr: '',
                        startTimeStr: '',
                        endTimeStr: '',
                    };
                }

                var yyyy = start.getFullYear();
                var mm = String(start.getMonth() + 1).padStart(2, '0');
                var dd = String(start.getDate()).padStart(2, '0');
                var hh = String(start.getHours()).padStart(2, '0');
                var min = String(start.getMinutes()).padStart(2, '0');

                var dateStr = yyyy + '-' + mm + '-' + dd;
                var startTimeStr = hh + ':' + min;
                var endTimeStr = '이용중';

                if (checkOutTimestamp && Number(checkOutTimestamp) !== 0) {
                    var end = new Date(Number(checkOutTimestamp));
                    if (!isNaN(end.getTime())) {
                        var endHh = String(end.getHours()).padStart(2, '0');
                        var endMin = String(end.getMinutes()).padStart(2, '0');
                        endTimeStr = endHh + ':' + endMin;
                    }
                }

                return {
                    dateStr: dateStr,
                    startTimeStr: startTimeStr,
                    endTimeStr: endTimeStr,
                };
            }

            function serviceAlert(message, options) {
                document.getElementById('infoModalMessage').innerText = message;
                openModal('infoModal');

                var okBtn = document.getElementById('infoModalOk');
                okBtn.onclick = function () {
                    closeModal('infoModal');

                    if (options && options.reload === true) {
                        location.reload();
                    }

                    if (options && typeof options.callback === 'function') {
                        options.callback();
                    }
                };
            }

            function openModal(id) {
                document.getElementById(id).style.display = 'flex';
                document.body.style.overflow = 'hidden'; // 배경 스크롤 방지
            }

            function closeModal(id) {
                document.getElementById(id).style.display = 'none';
                document.body.style.overflow = ''; // 스크롤 복원
            }
        </script>
    </body>
</html>
