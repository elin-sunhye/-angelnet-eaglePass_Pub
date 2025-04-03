// 비밀번호 보기 가리기 버튼
$(document).on(
    'click',
    '.login__cont__box__btn-password, .signup__cont__box__btn-password',
    function () {
        const firstImg = $(this).find('img').eq(0); // 첫 번째 이미지
        const secondImg = $(this).find('img').eq(1); // 두 번째 이미지
        const passwordInput = $('#password'); // 비밀번호 입력 필드 가져오기

        if (passwordInput.attr('type') === 'password') {
            passwordInput.attr('type', 'text'); // 비밀번호 보이기
            firstImg.show(); // 첫 번째 이미지 표시
            secondImg.hide(); // 두 번째 이미지 숨김
        } else {
            passwordInput.attr('type', 'password'); // 비밀번호 숨기기
            firstImg.hide(); // 첫 번째 이미지 숨김
            secondImg.show(); // 두 번째 이미지 표시
        }
    }
);

// 타석예약 층 탭
$(document).on('click', '.tab-box__tab-top__btn-tab button', function () {
    // 모든 버튼에서 'on' 클래스 제거
    $('.tab-box__tab-top__btn-tab button').removeClass('on');
    // 클릭한 버튼에 'on' 클래스 추가
    $(this).addClass('on');

    // 모든 층 cont 숨기기
    $('.tab-box__tab-cont > div').removeClass('on');

    // 클릭한 버튼의 인덱스를 가져와 해당 층 cont 표시
    let index = $(this).index();
    $('.tab-box__tab-cont > div').eq(index).addClass('on');
});

// 타석예약 시간 타석 클릭
// $(document).on(
//     'click',
//     '.tab-box__tab-cont > div .floor__row .floor__row__col:last-of-type',
//     function () {
//         if ($(this).text().trim() !== '이용중') {
//             if ($(this).hasClass('on')) {
//                 // 클릭한 버튼에서 'on' 클래스 제거
//                 $(this).removeClass('on');
//             } else {
//                 // 모든 버튼에서 'on' 클래스 제거
//                 $(
//                     '.tab-box__tab-cont > div .floor__row .floor__row__col:last-of-type'
//                 ).removeClass('on');
//                 // 클릭한 버튼에 'on' 클래스 추가
//                 $(this).addClass('on');
//             }
//         }
//     }
// );

// 타석예약 불가
function used() {
    $('.tab-box__tab-cont > div .floor__row .floor__row__col').each(
        function () {
            if ($(this).text().trim().includes('불가')) {
                // 버튼 텍스트가 불가면
                $(this).addClass('used'); // 사용중 클래스 추가
            }
        }
    );
}
used();

// 타석예약 분 이용
function shortTime() {
    $('.tab-box__tab-cont > div .floor__row .floor__row__col').each(
        function () {
            if ($(this).text().trim().includes('이용')) {
                // 버튼 텍스트가 이용
                $(this).addClass('short'); // short 클래스 추가
            }
        }
    );
}
shortTime();

// 타석예약 선택 이전 시간 체크
// function before() {
//     $(
//         '.tab-box__tab-cont > div .floor__row .floor__row__col:last-of-type'
//     ).each(function () {
//         if ($(this).find('span').length > 0) {
//             $(this).addClass('before');
//         }
//     });
// }
// before();

// 내 예약 모달 열기
$(document).on(
    'click',
    '.tab-box__tab-cont > div .floor__row .floor__row__col:last-of-type',
    function () {
        $(
            '.tab-box__tab-cont > div .floor__row .floor__row__col:last-of-type'
        ).removeClass('on'); // 'open' 클래스 삭제
        $(this).addClass('on'); // 'open' 클래스 추가
        $('.my-booking').fadeIn(300); // 3초동안 fadeIn
    }
);

// 내 예약 시간 선택
$(document).on('click', '.modal_row.time .time_box button', function () {
    $('.modal_row.time .time_box button').removeClass('on'); // 'open' 클래스 삭제
    $(this).addClass('on');
});

// 내 예약 모달 닫기
$(document).on('click', '.btn-modal-pop-up-close', function () {
    $(
        '.tab-box__tab-cont > div .floor__row .floor__row__col:last-of-type'
    ).removeClass('on'); // 'open' 클래스 삭제
    $('.my-booking').fadeOut(300); // 3초동안 fadeOut
});

// 배치도 모달 열기
$(document).on('click', '.btn-modal-pop-up', function () {
    $('.btn-modal-pop-up').addClass('open'); // 'open' 클래스 추가
    $('.position').fadeIn(300); // 3초동안 fadeIn
});

// 배치도 모달 닫기
$(document).on('click', '.btn-modal-pop-up-close', function () {
    $('.btn-modal-pop-up').removeClass('open'); // 'open' 클래스 제거
    $('.position').fadeOut(300); // 3초동안 fadeOut
});

// 상품 구매
$(document).on('click', '.product', function () {
    if ($(this).hasClass('on')) {
        // 클릭한 버튼에서 'on' 클래스 제거
        $(this).removeClass('on');
    } else {
        // 모든 버튼에서 'on' 클래스 제거
        $('.product').removeClass('on');
        // 클릭한 버튼에 'on' 클래스 추가
        $(this).addClass('on');
    }
});
