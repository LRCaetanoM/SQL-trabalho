CREATE TABLE CLIENTE (
IDCliente INT PRIMARY KEY, 
CPF varchar(11) UNIQUE not null,
RG varchar(9) UNIQUE not null,
IDTutor INT,
ContaAtiva BOOLEAN,
endereco varchar(30) not null
);

ALTER TABLE Cliente 
ADD constraint fk_idtutor
foreign key (IDTutor)
REFERENCES Cliente(IDCliente)

CREATE TABLE Telefone_Cliente(
id_cliente int,
telefone varchar(11)
);

ALTER TABLE Telefone_Cliente
ADD constraint fk_cliente foreign key (id_cliente) references CLIENTE(IDCliente)

CREATE TABLE Fiado(
CodFiado int primary key,
valor float(10),
data_registro_fiado date,
data_lim_pagamento_fiado date,
id_cliente int 
)

ALTER TABLE Fiado
ADD constraint fk_cliente_fiado foreign key (id_cliente) references CLIENTE(IDCliente)


-- Trigger para definir data_lim_pagamento_fiado automaticamente
CREATE TRIGGER set_data_lim_pagamento
BEFORE INSERT ON Fiado
FOR EACH ROW
BEGIN (SET NEW.data_lim_pagamento_fiado) = DATE_ADD(NEW.data_registro_fiado, INTERVAL 30 DAY);
END;

CREATE TABLE formas_pagamento(
formas varchar(20)
)

INSERT INTO formas_pagamento(formas) VALUES ('cartão débito'),('dinheiro'), ('pix')

CREATE TABLE Pagamento(
IDPagamento varchar(10) PRIMARY KEY,
FOREIGN KEY (CodFiado) REFERENCES Fiado(CodFiado),
valor float(10),
data_pagamento date,
FOREIGN KEY (forma_pagamento_mes) REFERENCES formas_pagamento(formas)	
)

CREATE TABLE