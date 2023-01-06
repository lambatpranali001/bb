apt install golang -y
updatedb
echo "export PATH=/root/go/bin:$PATH" >> ~/.zshrc
source ~/.zshrc
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
read -p "enter domain: " domain
#domain=sfox.com
subfinder -d $domain -all -silent -recursive | tee subdomains.txt
a = $(cat subdomain.txt | wc -l)
echo $a
git clone https://github.com/vortexau/dnsvalidator.git
cd dnsvalidator
pip3 install -r requirements .txt
python3 setup.py install
dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 100 -o resolvers.txt
cd ../
mkdir /tools
cd /tools
go install github.com/Josue87/gotator@latest
gotator -sub $domain -perm words.list -silent | sort -u | tee newgensubs.txt | wc -l
cat subdomains.txt newgensubs.txt | tee all.txt
go install github.com/d3mondev/puredns/v2@latest
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
make install
cd ../
mv ...........# add resolvers
pure dns resolve all.txt --write final.txt
