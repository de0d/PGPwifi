openssl genpkey -algorithm rsa > private.pem
openssl rsa -pubout -in private.pem -out public.pem

