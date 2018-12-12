CREATE TABLE IF NOT EXISTS visible (
  id TINYINT(1) NOT NULL,
  label VARCHAR(32),
  PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO visible(id, label) VALUES ('8', 'PRIVATE');
INSERT INTO visible(id, label) VALUES ('16', 'PROTECTED');
INSERT INTO visible(id, label) VALUES ('32', 'PUBLIC');

CREATE TABLE IF NOT EXISTS status (
  id TINYINT(1) NOT NULL,
  label VARCHAR(32),
  PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO status(id, label) VALUES ('5', 'CREATING');
INSERT INTO status(id, label) VALUES ('10', 'STOPPED');
INSERT INTO status(id, label) VALUES ('20', 'RUNNING');
INSERT INTO status(id, label) VALUES ('15', 'DELETING');
INSERT INTO status(id, label) VALUES ('25', 'STARTING');
INSERT INTO status(id, label) VALUES ('30', 'STOPING');
INSERT INTO status(id, label) VALUES ('0', 'UNKNOWN');

CREATE TABLE IF NOT EXISTS users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL,
  u_owner VARCHAR(32) NOT NULL,
  u_group VARCHAR(32) NOT NULL,
  creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE UNIQUE INDEX email_idx ON users (email);
CREATE UNIQUE INDEX owner_idx ON users (u_owner);
CREATE INDEX group_idx ON users (m_group);

INSERT INTO users(id, u_owner, u_group) VALUES ('1', 'yoctu','yoctu');

CREATE TABLE IF NOT EXISTS machines (
  id INT(11) NOT NULL AUTO_INCREMENT,
  host_name VARCHAR(32) NOT NULL,
  m_status TINYINT(1),
  m_owner VARCHAR(32) NOT NULL,
  m_group VARCHAR(32) NOT NULL,
  m_type VARCHAR(16) NOT NULL,
  visible TINYINT(1) NOT NULL DEFAULT 16,
  m_comment VARCHAR(255),
  creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (m_status) REFERENCES status(id),
  FOREIGN KEY (visible) REFERENCES visible(id)
) ENGINE=InnoDB;

CREATE UNIQUE INDEX hostname_idx ON machines (hostname);
CREATE INDEX group_idx ON machines (m_group);
CREATE INDEX owner_idx ON machines (m_owner);
