import 'package:flutter/material.dart';

class LearningPathScreen extends StatelessWidget {
  const LearningPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Trilha de Aprendizagem',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Avance módulo por módulo até dominar o Cálculo.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 24),
              _ModuleCard(
                title: 'Fundamentos Matemáticos',
                subtitle: 'Pré-Cálculo, funções e base algébrica',
                status: '0%',
                statusColor: Color(0xFF2563EB),
              ),
              SizedBox(height: 16),
              _ModuleCard(
                title: 'Cálculo I',
                subtitle: 'Limites, continuidade e derivadas',
                status: 'Bloqueado',
                statusColor: Color(0xFF94A3B8),
              ),
              SizedBox(height: 16),
              _ModuleCard(
                title: 'Cálculo II',
                subtitle: 'Integrais, séries e equações diferenciais',
                status: 'Bloqueado',
                statusColor: Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _LearningPathBottomNavigationBar(),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;

  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 96,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningPathBottomNavigationBar extends StatelessWidget {
  const _LearningPathBottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            label: 'Início',
            isActive: false,
          ),
          _BottomNavItem(
            label: 'Trilha',
            isActive: true,
          ),
          _BottomNavItem(
            label: 'Estatísticas',
            isActive: false,
          ),
          _BottomNavItem(
            label: 'Perfil',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final bool isActive;

  const _BottomNavItem({
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        color: isActive ? const Color(0xFF2563EB) : const Color(0xFF64748B),
      ),
    );
  }
}