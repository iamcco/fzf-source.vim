# ============================================================================
# FILE: fzfsource.py
# AUTHOR: 年糕小豆汤 <ooiss@qq.com>
# License: MIT license
# ============================================================================

from denite import util
from .base import Base
from ..kind.base import Base as BaseKind

class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'fzf'
        self.kind = Kind(vim)

    def gather_candidates(self, context):
        sources = self.vim.call('fzfsource#get_fzf_commands')
        candidata = []
        for source in sources:
            candidata.append({
                'word': source.strip(),
                })
        return candidata

class Kind(BaseKind):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'source'
        self.default_action = 'trigger'

    def action_trigger(self, context):
        target = context['targets'][0]
        command = target['word']
        self.vim.call('fzfsource#do_action', command)

    def action_args(self, context):
        target = context['targets'][0]
        command = target['word']
        args = util.input(self.vim, context, 'Enter args: ')
        args = args.split(':')
        self.vim.call('fzfsource#do_action', command, args)
