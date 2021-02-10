#! /bin/bash
# Wynikiem musi być skrypt bash.

echo "IP Addresses in logs:"
while read -r line
do
	# Trzeba:
	# • Wyświetlić tylko adresy IP,
	# • Usunąć remote_addr=
	ip="$(echo "$line" | awk '/remote_addr=/ { print $2 }' | sed 's/remote_addr=//')"
	if [ -n "${ip}" ]; then printf '%s' "$ip" | awk NF | tee -a tmp.txt
	fi
done < logs.txt

# • Posortować
sort -r -o tmp.txt tmp.txt
# • Wyświetlić zduplikowane adresy IP
echo -e "\nDuplicates:\n$(uniq -d < tmp.txt)"
# • Usunąć duplikaty.
echo -e "\nUnique IP addresses:\n$(uniq tmp.txt)"

rm -f tmp.txt
