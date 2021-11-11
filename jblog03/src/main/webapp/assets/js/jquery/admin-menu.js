window.onload = function() {
	var menuName = location.href.split('/').slice(-1)[0]

	var nameOfLis = ['basic', 'category', 'write'];
	var lis = document.getElementsByClassName("admin-menu")[0].getElementsByTagName("li");

	for (var i = 0; i < nameOfLis.length; i++) {
		if (menuName === nameOfLis[i]) {
			lis[i].className = "selected";
		}
	}
}