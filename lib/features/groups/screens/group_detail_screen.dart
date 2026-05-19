import 'package:flutter/material.dart';

class GroupDetailScreen extends StatefulWidget {
  final Map<String, dynamic> groupData;

  const GroupDetailScreen({super.key, required this.groupData});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Makan Malam',
      'amount': 350000.0,
      'paidBy': 'Budi',
      'date': '02 Juli 2026',
      'splitMethod': 'equal',
      'debts': [
        {'name': 'Andi', 'amount': 87500.0, 'paid': false},
        {'name': 'Cici', 'amount': 87500.0, 'paid': true},
        {'name': 'Deni', 'amount': 87500.0, 'paid': false},
      ],
    },
    {
      'title': 'Tiket Masuk',
      'amount': 200000.0,
      'paidBy': 'Andi',
      'date': '02 Juli 2026',
      'splitMethod': 'equal',
      'debts': [
        {'name': 'Budi', 'amount': 50000.0, 'paid': true},
        {'name': 'Cici', 'amount': 50000.0, 'paid': false},
        {'name': 'Deni', 'amount': 50000.0, 'paid': false},
      ],
    },
  ];

  void _showAddTransactionModal() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedMethod = 'equal';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
                top: 24,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  const Text(
                    'Tambah Transaksi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Scan or Manual toggle
                  Row(
                    children: [
                      Expanded(
                        child: _methodTab(
                          icon: Icons.document_scanner_rounded,
                          label: 'Scan Nota',
                          selected: false,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _methodTab(
                          icon: Icons.edit_rounded,
                          label: 'Input Manual',
                          selected: true,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Title field
                  _modalTextField(
                    controller: titleController,
                    hint: 'Nama pengeluaran',
                    icon: Icons.receipt_long_rounded,
                  ),
                  const SizedBox(height: 12),

                  // Amount field
                  _modalTextField(
                    controller: amountController,
                    hint: 'Jumlah (Rp)',
                    icon: Icons.attach_money_rounded,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  // Split method
                  const Text(
                    'Metode Split Bill',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _splitChip('Rata-rata', 'equal', selectedMethod, (v) => setModalState(() => selectedMethod = v)),
                      const SizedBox(width: 8),
                      _splitChip('Persentase', 'percent', selectedMethod, (v) => setModalState(() => selectedMethod = v)),
                      const SizedBox(width: 8),
                      _splitChip('Custom', 'custom', selectedMethod, (v) => setModalState(() => selectedMethod = v)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Add button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        final amountText = amountController.text.trim();
                        if (title.isEmpty || amountText.isEmpty) return;
                        final amount = double.tryParse(amountText.replaceAll('.', '')) ?? 0;
                        final perPerson = amount / 4;
                        setState(() {
                          _transactions.insert(0, {
                            'title': title,
                            'amount': amount,
                            'paidBy': 'Username',
                            'date': 'Hari ini',
                            'splitMethod': selectedMethod,
                            'debts': [
                              {'name': 'Andi', 'amount': perPerson, 'paid': false},
                              {'name': 'Budi', 'amount': perPerson, 'paid': false},
                              {'name': 'Cici', 'amount': perPerson, 'paid': false},
                            ],
                          });
                        });
                        Navigator.pop(context);
                        _showTransactionDetail(_transactions.first);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C4DFF),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text(
                        'Tambah & Generate Hutang',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showTransactionDetail(Map<String, dynamic> tx) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(24),
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C4DFF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.receipt_rounded, color: Color(0xFF7C4DFF)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tx['title'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        Text(
                          'Dibayar oleh ${tx['paidBy']}  •  ${tx['date']}',
                          style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _formatRupiah(tx['amount'] as double),
                    style: const TextStyle(
                      color: Color(0xFF7C4DFF),
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text(
                'Yang Harus Dibayar',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E), fontSize: 15),
              ),
              const SizedBox(height: 12),

              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: (tx['debts'] as List).length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final debt = (tx['debts'] as List)[i] as Map<String, dynamic>;
                    final isPaid = debt['paid'] as bool;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isPaid
                            ? Colors.green.withOpacity(0.06)
                            : const Color(0xFF7C4DFF).withOpacity(0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isPaid
                              ? Colors.green.withOpacity(0.2)
                              : const Color(0xFF7C4DFF).withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: isPaid
                                ? Colors.green.withOpacity(0.15)
                                : const Color(0xFF7C4DFF).withOpacity(0.15),
                            child: Text(
                              (debt['name'] as String)[0],
                              style: TextStyle(
                                color: isPaid ? Colors.green : const Color(0xFF7C4DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              debt['name'] as String,
                              style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E)),
                            ),
                          ),
                          Text(
                            _formatRupiah(debt['amount'] as double),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: isPaid ? Colors.green : const Color(0xFF7C4DFF),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPaid ? Colors.green : Colors.orange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isPaid ? 'Lunas' : 'Belum',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatRupiah(double amount) {
    final formatted = amount.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
    return 'Rp $formatted';
  }

  Widget _methodTab({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF7C4DFF).withOpacity(0.1) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF7C4DFF).withOpacity(0.4) : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: selected ? const Color(0xFF7C4DFF) : const Color(0xFF9E9E9E)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: selected ? const Color(0xFF7C4DFF) : const Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modalTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF7C4DFF), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }

  Widget _splitChip(String label, String value, String selected, ValueChanged<String> onTap) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7C4DFF) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF9E9E9E),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final group = widget.groupData;
    final color = group['color'] as Color;
    final totalAmount = _transactions.fold<double>(
      0,
      (sum, tx) => sum + (tx['amount'] as double),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color(0xFF1A1A2E)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      group['name'] as String,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF1A1A2E)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Summary Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color, color.withOpacity(0.75)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  group['emoji'] as String,
                                  style: const TextStyle(fontSize: 28),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group['name'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        group['date'] as String,
                                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            const Text('Total Pengeluaran', style: TextStyle(color: Colors.white70, fontSize: 13)),
                            const SizedBox(height: 4),
                            Text(
                              _formatRupiah(totalAmount),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                _statBadge('${_transactions.length} Transaksi', Icons.receipt_rounded),
                                const SizedBox(width: 10),
                                _statBadge('4 Anggota', Icons.people_rounded),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Transactions Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Transaksi',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          if (_transactions.isNotEmpty)
                            Text(
                              '${_transactions.length} item',
                              style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 13),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Transaction List
                    if (_transactions.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Icon(Icons.receipt_long_rounded, size: 48, color: color.withOpacity(0.3)),
                            const SizedBox(height: 12),
                            const Text(
                              'Belum ada transaksi\nTambahkan catatan pengeluaran pertama!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _transactions.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (ctx, i) {
                          final tx = _transactions[i];
                          final debts = tx['debts'] as List;
                          final unpaid = debts.where((d) => !(d['paid'] as bool)).length;

                          return GestureDetector(
                            onTap: () => _showTransactionDetail(tx),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Icon(Icons.receipt_rounded, color: color, size: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              tx['title'] as String,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Color(0xFF1A1A2E),
                                              ),
                                            ),
                                            Text(
                                              'Dibayar ${tx['paidBy']}  •  ${tx['date']}',
                                              style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _formatRupiah(tx['amount'] as double),
                                        style: TextStyle(
                                          color: color,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (unpaid > 0) ...[
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.orange.withOpacity(0.3)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.warning_amber_rounded, size: 14, color: Colors.orange),
                                          const SizedBox(width: 6),
                                          Text(
                                            '$unpaid orang belum bayar',
                                            style: const TextStyle(
                                              color: Colors.orange,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTransactionModal,
        backgroundColor: color,
        elevation: 6,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Tambah Transaksi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _statBadge(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 15),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}