<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250327012636 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE bell (id UUID NOT NULL, name VARCHAR(50) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('COMMENT ON COLUMN bell.id IS \'(DC2Type:uuid)\'');
        $this->addSql('CREATE TABLE curriculum (id UUID NOT NULL, grade_id UUID DEFAULT NULL, subject_id UUID DEFAULT NULL, hours INT NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_7BE2A7C3FE19A1A8 ON curriculum (grade_id)');
        $this->addSql('CREATE INDEX IDX_7BE2A7C323EDC87 ON curriculum (subject_id)');
        $this->addSql('COMMENT ON COLUMN curriculum.id IS \'(DC2Type:uuid)\'');
        $this->addSql('COMMENT ON COLUMN curriculum.grade_id IS \'(DC2Type:uuid)\'');
        $this->addSql('COMMENT ON COLUMN curriculum.subject_id IS \'(DC2Type:uuid)\'');
        $this->addSql('CREATE TABLE grade (id UUID NOT NULL, name VARCHAR(50) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('COMMENT ON COLUMN grade.id IS \'(DC2Type:uuid)\'');
        $this->addSql('CREATE TABLE grade_subject (grade_id UUID NOT NULL, subject_id UUID NOT NULL, PRIMARY KEY(grade_id, subject_id))');
        $this->addSql('CREATE INDEX IDX_183AC98FE19A1A8 ON grade_subject (grade_id)');
        $this->addSql('CREATE INDEX IDX_183AC9823EDC87 ON grade_subject (subject_id)');
        $this->addSql('COMMENT ON COLUMN grade_subject.grade_id IS \'(DC2Type:uuid)\'');
        $this->addSql('COMMENT ON COLUMN grade_subject.subject_id IS \'(DC2Type:uuid)\'');
        $this->addSql('CREATE TABLE subject (id UUID NOT NULL, teacher_id UUID DEFAULT NULL, name VARCHAR(50) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_FBCE3E7A41807E1D ON subject (teacher_id)');
        $this->addSql('COMMENT ON COLUMN subject.id IS \'(DC2Type:uuid)\'');
        $this->addSql('COMMENT ON COLUMN subject.teacher_id IS \'(DC2Type:uuid)\'');
        $this->addSql('CREATE TABLE teacher (id UUID NOT NULL, name VARCHAR(100) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('COMMENT ON COLUMN teacher.id IS \'(DC2Type:uuid)\'');
        $this->addSql('CREATE TABLE weekday (id UUID NOT NULL, name VARCHAR(20) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('COMMENT ON COLUMN weekday.id IS \'(DC2Type:uuid)\'');
        $this->addSql('CREATE TABLE messenger_messages (id BIGSERIAL NOT NULL, body TEXT NOT NULL, headers TEXT NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, available_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, delivered_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_75EA56E0FB7336F0 ON messenger_messages (queue_name)');
        $this->addSql('CREATE INDEX IDX_75EA56E0E3BD61CE ON messenger_messages (available_at)');
        $this->addSql('CREATE INDEX IDX_75EA56E016BA31DB ON messenger_messages (delivered_at)');
        $this->addSql('COMMENT ON COLUMN messenger_messages.created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN messenger_messages.available_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN messenger_messages.delivered_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('CREATE OR REPLACE FUNCTION notify_messenger_messages() RETURNS TRIGGER AS $$
            BEGIN
                PERFORM pg_notify(\'messenger_messages\', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$ LANGUAGE plpgsql;');
        $this->addSql('DROP TRIGGER IF EXISTS notify_trigger ON messenger_messages;');
        $this->addSql('CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON messenger_messages FOR EACH ROW EXECUTE PROCEDURE notify_messenger_messages();');
        $this->addSql('ALTER TABLE curriculum ADD CONSTRAINT FK_7BE2A7C3FE19A1A8 FOREIGN KEY (grade_id) REFERENCES grade (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE curriculum ADD CONSTRAINT FK_7BE2A7C323EDC87 FOREIGN KEY (subject_id) REFERENCES subject (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE grade_subject ADD CONSTRAINT FK_183AC98FE19A1A8 FOREIGN KEY (grade_id) REFERENCES grade (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE grade_subject ADD CONSTRAINT FK_183AC9823EDC87 FOREIGN KEY (subject_id) REFERENCES subject (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE subject ADD CONSTRAINT FK_FBCE3E7A41807E1D FOREIGN KEY (teacher_id) REFERENCES teacher (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE curriculum DROP CONSTRAINT FK_7BE2A7C3FE19A1A8');
        $this->addSql('ALTER TABLE curriculum DROP CONSTRAINT FK_7BE2A7C323EDC87');
        $this->addSql('ALTER TABLE grade_subject DROP CONSTRAINT FK_183AC98FE19A1A8');
        $this->addSql('ALTER TABLE grade_subject DROP CONSTRAINT FK_183AC9823EDC87');
        $this->addSql('ALTER TABLE subject DROP CONSTRAINT FK_FBCE3E7A41807E1D');
        $this->addSql('DROP TABLE bell');
        $this->addSql('DROP TABLE curriculum');
        $this->addSql('DROP TABLE grade');
        $this->addSql('DROP TABLE grade_subject');
        $this->addSql('DROP TABLE subject');
        $this->addSql('DROP TABLE teacher');
        $this->addSql('DROP TABLE weekday');
        $this->addSql('DROP TABLE messenger_messages');
    }
}
