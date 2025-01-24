document.addEventListener('DOMContentLoaded', function() {
    // 현재 시간을 한국 시간으로 표시
    const now = new Date();
    const options = {
        timeZone: 'Asia/Seoul',
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    };
    
    const formatter = new Intl.DateTimeFormat('ko-KR', options);
    const deployTime = formatter.format(now);
    
    // 배포 시간 업데이트
    document.getElementById('deployTime').textContent = deployTime;

    // 성공 아이콘 애니메이션
    const successIcon = document.querySelector('.success-icon');
    successIcon.style.animation = 'bounce 2s infinite';
});