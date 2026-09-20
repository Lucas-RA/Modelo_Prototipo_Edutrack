enum RiskLevel { low, medium, high }

class ManagementStudent {
  final String id, name, rm, classId, partnerId, initials;
  final int attendance, moodle, riskScore, trendPp;
  final RiskLevel risk;
  final List<int> history7d;
  final String observation, attentionReason;
  const ManagementStudent(
      this.id,
      this.name,
      this.rm,
      this.classId,
      this.partnerId,
      this.initials,
      this.attendance,
      this.moodle,
      this.riskScore,
      this.risk,
      this.history7d,
      this.observation,
      this.trendPp,
      this.attentionReason);
}

class ManagementPartner {
  final String id, name, type, status;
  final int activeStudents, retention, certificates, employment;
  const ManagementPartner(this.id, this.name, this.type, this.activeStudents,
      this.retention, this.certificates, this.employment, this.status);
}

class ManagementClass {
  final String id, name, partnerId, shift, semester;
  final int totalStudents;
  const ManagementClass(this.id, this.name, this.partnerId, this.shift,
      this.semester, this.totalStudents);
}

class AttendanceRecord {
  final String studentId, date, justification;
  final bool present;
  const AttendanceRecord(
      this.studentId, this.date, this.present, this.justification);
}

class RiskFactor {
  final String studentId, label;
  final int contribution;
  const RiskFactor(this.studentId, this.label, this.contribution);
}

class MoodAggregate {
  final String week, classId;
  final List<(String, int, double)> levels;
  final int totalResponses;
  final double classPercent;
  const MoodAggregate(this.week, this.classId, this.levels, this.totalResponses,
      this.classPercent);
}

class SeriesPoint {
  final String period;
  final int first, second;
  final bool projection;
  const SeriesPoint(this.period, this.first, this.second,
      {this.projection = false});
}

class GraduateAggregate {
  final String category, description;
  final int count, percent;
  const GraduateAggregate(
      this.category, this.description, this.count, this.percent);
}

class LogEvent {
  final String timestamp, severity, message;
  const LogEvent(this.timestamp, this.severity, this.message);
}

class PipelineStage {
  final String type, name, description;
  final List<(String, String)> metrics;
  const PipelineStage(this.type, this.name, this.description, this.metrics);
}

class KpiData {
  final String label, value, detail, change;
  final RiskLevel tone;
  const KpiData(this.label, this.value, this.detail, this.change,
      {this.tone = RiskLevel.low});
}

class ScatterPoint {
  final double attendance, moodle;
  final RiskLevel risk;
  const ScatterPoint(this.attendance, this.moodle, this.risk);
}

class EducatorAlert {
  final String id, scope, subject, detail, elapsed, action;
  final RiskLevel severity;
  final bool resolved;
  const EducatorAlert(this.id, this.scope, this.subject, this.detail,
      this.elapsed, this.severity, this.action,
      {this.resolved = false});
}

class ReportItem {
  final String id, name, description, range, generated, format, size;
  final bool ready;
  const ReportItem(this.id, this.name, this.description, this.range,
      this.generated, this.format, this.size,
      {this.ready = true});
}

/// Participação no check-in — nunca o conteúdo da resposta (C4).
class CheckinParticipation {
  final String studentId, lastAnswer;
  final int daysSince;
  final bool wellbeingFlag;
  const CheckinParticipation(
      this.studentId, this.lastAnswer, this.daysSince, this.wellbeingFlag);
}

class Conversation {
  final String id, name, role, initials, preview, elapsed;
  final int unread;
  const Conversation(this.id, this.name, this.role, this.initials, this.preview,
      this.elapsed, this.unread);
}
