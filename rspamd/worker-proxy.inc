bind_socket = 0.0.0.0:11332;
milter = yes;
timeout = 120s;
upstream "local" {
	default = yes;
	self_scan = yes;
}
count = 1;
spam_header = "X-Spam";
spam_message = "Spam message rejected";

